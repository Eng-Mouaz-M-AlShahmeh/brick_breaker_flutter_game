/* Developed by Eng Mouaz M AlShahmeh */
import 'dart:async';
import 'package:brick_breaker_flutter_game/base/utils/constants.dart';
import 'package:brick_breaker_flutter_game/base/utils/shared_preference.dart';
import 'package:brick_breaker_flutter_game/model/brick_broken_type.dart';
import 'package:brick_breaker_flutter_game/model/direction.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brick_breaker_flutter_game/model/game_configuration.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  SharedPrefs sharedPrefs;

  GameController({required this.sharedPrefs});

  int _refreshDurationInMilliseconds = 20;
  bool _isGameStarted = false;

  RxInt level = 1.obs;
  RxInt currentLevel = 1.obs;

  late double brickWidth;
  late double brickHeight;
  late double _brickGapWidth;
  late double _brickGapHeight;
  late int _numberOfBrickInRow;
  late int _numberOfBrickInColumn;
  late double _firstBrickY;
  late double _firstBrickX;
  late double _wallGap;
  late int _brickBrokenHits;
  RxBool brickBroken = false.obs;
  Rx<BrickBrokenType> allBricksBroken = BrickBrokenType.notBroken.obs;
  RxList bricks = [].obs;

  RxList balls = [].obs;
  final double _ballXIncrements = 0.01;
  final double _ballYIncrements = 0.01;

  Rx<ValueNotifier<double>> playerX = ValueNotifier(-0.2).obs;
  RxBool playerShown = true.obs;
  RxBool playerDead = false.obs;
  double playerWidth = 0.5;

  RxDouble awardX = 0.0.obs;
  RxDouble awardY = 1.0.obs;
  Rx<IconData> awardIconData = Icons.gamepad.obs;
  final double _awardYIncrements = 0.01;
  RxBool awardShown = false.obs;
  int brickAwardTime = 0;

  late List<Color> mainColor, mainColorLight;

  void loadLevel() {
    level.value = (sharedPrefs.getInt("level") ?? 1);
  }

  void initLevel(int level, List<Color> mColor, List<Color> mColorLight) {
    mainColor = mColor;
    mainColorLight = mColorLight;
    currentLevel.value = level;
    if (currentLevel > 10) {
      _refreshDurationInMilliseconds = 7;
    }
    _initBricks();
    _initBalls();
    resetGame();
  }

  void updateLevel() {
    if (currentLevel.value < Constants.levels) {
      currentLevel.value++;
      int savedLevel = sharedPrefs.getInt("level") ?? 1;
      if (currentLevel.value > savedLevel) {
        sharedPrefs.putInt("level", currentLevel.value);
        level.value = currentLevel.value;
      }
      allBricksBroken.value = BrickBrokenType.allBroken;
    } else {
      allBricksBroken.value = BrickBrokenType.allBrokenAndGameEnded;
    }
  }

  void _initBalls() {
    balls.add([0.0, 0.0, true, Direction.left, Direction.down]);
    balls.refresh();
  }

  void _initBricks() async {
    final String level = await rootBundle
        .loadString("assets/levels/" + currentLevel.value.toString() + ".json");
    final jsonResult = jsonDecode(level);
    final brickConfiguration = BrickConfiguration(
      row: jsonResult['row'],
      column: jsonResult['column'],
      matrix: jsonResult['matrix'],
      widthGap: jsonResult['widthGap'],
      heightGap: jsonResult['heightGap'],
      brickBrokenHits: jsonResult['brickBrokenHits'],
      brickWidth: jsonResult['brickWidth'],
      brickHeight: jsonResult['brickHeight'],
    );

    brickWidth = brickConfiguration.brickWidth;
    brickHeight = brickConfiguration.brickHeight;
    _brickBrokenHits = brickConfiguration.brickBrokenHits;
    _numberOfBrickInRow = brickConfiguration.row;
    _numberOfBrickInColumn = brickConfiguration.column;
    _brickGapWidth = brickConfiguration.widthGap;
    _brickGapHeight = brickConfiguration.heightGap;

    _wallGap = 0.5 *
        (2 -
            _numberOfBrickInRow * brickWidth -
            (_numberOfBrickInRow - 1) * _brickGapWidth);
    _firstBrickY = -0.7;
    _firstBrickX = -1 + _wallGap;

    bricks.clear();
    for (int i = 0; i < _numberOfBrickInRow; i++) {
      for (int j = 0; j < _numberOfBrickInColumn; j++) {
        int matrix = brickConfiguration.matrix[i][j];
        if (matrix != 0) {
          bricks.add([
            _firstBrickX + i * (brickWidth + _brickGapWidth),
            _firstBrickY + j * (brickHeight + _brickGapHeight),
            _brickBrokenHits,
            mainColor[i],
            mainColorLight[i],
          ]);
        }
      }
    }
    bricks.refresh();
  }

  void startGame() {
    if (!_isGameStarted) {
      Timer.periodic(Duration(milliseconds: _refreshDurationInMilliseconds),
          (timer) {
        _isGameStarted = true;
        _updateDirection();
        _moveBall();
        _checkForAward();
        _updateAward();
        _checkPlayerDead(timer);
        _checkBricksBroken(timer);
      });
    }
  }

  void _checkPlayerDead(Timer timer) async {
    for (int i = 0; i < balls.length;) {
      if (balls[i][1] >= 1) {
        balls.removeAt(i);
      } else {
        i++;
      }
    }
    if (balls.isEmpty) {
      // player dead
      playerDead.value = true;
      timer.cancel();
    }
  }

  void resetGame() {
    _initBricks();
    _isGameStarted = false;
    playerX.value.value = (-0.2);
    playerShown.value = true;
    playerDead.value = false;
    allBricksBroken.value = BrickBrokenType.notBroken;

    balls.clear();
    _initBalls();

    for (int i = 0; i < bricks.length; i++) {
      bricks[i][2] = 1;
    }
    bricks.refresh();
  }

  void _checkForAward() {
    if (awardY.value >= 0.9 &&
        awardX.value >= playerX.value.value &&
        awardX.value <= playerX.value.value + playerWidth &&
        awardShown.value) {
      if (playerWidth == 0.9) {
        balls.add([0.0, -0.6, true, Direction.left, Direction.down]);
        balls.refresh();
      } else {
        playerWidth = 0.9;
        awardX.value = 0.0;
        awardY.value = 0.0;
        awardShown.value = false;

        Future.delayed(const Duration(seconds: 15), () {
          playerWidth = 0.5;
        });
      }
    }
  }

  void _addAward(double x, double y, IconData iconData) {
    if (awardShown.value == false) {
      awardX.value = x;
      awardY.value = y;
      awardIconData.value = iconData;
      awardShown.value = true;
    }
  }

  void _updateAward() {
    if (awardY >= 0.9) {
      awardShown.value = false;
      return;
    }
    awardY.value += _awardYIncrements;
  }

  void _checkBricksBroken(Timer timer) {
    for (int i = 0; i < bricks.length; i++) {
      for (int j = 0; j < balls.length; j++) {
        if (balls[j][0] >= bricks[i][0] &&
            balls[j][0] <= bricks[i][0] + brickWidth &&
            balls[j][1] <= bricks[i][1] + brickHeight &&
            balls[j][1] >= bricks[i][1] &&
            bricks[i][2] > 0) {
          brickBroken.value = true;
          brickBroken.refresh();

          bricks[i][2]--;

          if (brickAwardTime > 0) {
            int currentTime = DateTime.now().second;
            if (currentTime - brickAwardTime <= 1) {
              _addAward(balls[j][0], balls[j][1],
                  playerWidth == 0.9 ? Icons.circle_outlined : Icons.gamepad);
            }
          }
          brickAwardTime = DateTime.now().second;

          double leftSideDist = (bricks[i][0] - balls[j][0]).abs();
          double rightSideDist =
              (bricks[i][0] + brickWidth - balls[j][0]).abs();
          double topSideDist = (bricks[i][1] - balls[j][1]).abs();
          double bottomSideDist =
              (bricks[i][1] + brickHeight - balls[j][1]).abs();

          Direction min = _findMin(
              leftSideDist, rightSideDist, topSideDist, bottomSideDist);
          switch (min) {
            case Direction.left:
              balls[j][3] = Direction.left;
              break;
            case Direction.right:
              balls[j][3] = Direction.right;
              break;
            case Direction.up:
              balls[j][4] = Direction.up;
              break;
            case Direction.down:
              balls[j][4] = Direction.down;
              break;
            case Direction.none:
              break;
          }
        }
      }
    }
    _checkAllBricksBroken(timer);
  }

  void _checkAllBricksBroken(Timer timer) async {
    bool allBroken = true;
    for (int i = 0; i < bricks.length; i++) {
      if (bricks[i][2] > 0) {
        allBroken = false;
      }
    }
    if (allBroken) {
      updateLevel();
      balls.clear();
      balls.refresh();
      timer.cancel();
      playerShown.value = false;
    }
  }

  Direction _findMin(double a, double b, double c, double d) {
    List<double> list = [a, b, c, d];
    double currentMin = a;
    for (int i = 0; i < list.length; i++) {
      if (currentMin > list[i]) {
        currentMin = list[i];
      }
    }
    if ((currentMin - a).abs() < 0.01) {
      return Direction.left;
    } else if ((currentMin - b).abs() < 0.01) {
      return Direction.right;
    } else if ((currentMin - c).abs() < 0.01) {
      return Direction.up;
    } else if ((currentMin - d).abs() < 0.01) {
      return Direction.down;
    }
    return Direction.none;
  }

  void _updateDirection() {
    for (int i = 0; i < balls.length; i++) {
      if (balls[i][1] >= 0.9 &&
          balls[i][0] + 0.06 >= playerX.value.value &&
          balls[i][0] - 0.06 <= playerX.value.value + playerWidth) {
        //0.06 width of balls
        balls[i][4] = Direction.up;
      } else if (balls[i][1] <= -1) {
        balls[i][4] = Direction.down;
      }

      if (balls[i][0] >= 1) {
        balls[i][3] = Direction.left;
      } else if (balls[i][0] <= -1) {
        balls[i][3] = Direction.right;
      }
    }
    balls.refresh();
  }

  void _moveBall() {
    for (int i = 0; i < balls.length; i++) {
      if (balls[i][3] == Direction.left) {
        balls[i][0] -= _ballXIncrements;
      } else if (balls[i][3] == Direction.right) {
        balls[i][0] += _ballXIncrements;
      }

      if (balls[i][4] == Direction.down) {
        balls[i][1] += _ballYIncrements;
      } else if (balls[i][4] == Direction.up) {
        balls[i][1] -= _ballYIncrements;
      }
    }
    balls.refresh();
  }

  void movePlayerLeft(double delta) {
    if (!(playerX.value.value - delta.abs() < -1)) {
      playerX.value.value -= delta.abs();
    }
  }

  void movePlayerRight(double delta) {
    if (!(playerX.value.value + playerWidth + delta.abs() > 1)) {
      playerX.value.value += delta.abs();
    }
  }

  void disposeGame() {
    currentLevel.close();
    level.close();
    bricks.close();
    balls.close();
    playerX.close();
    playerShown.close();
    playerDead.close();
    allBricksBroken.close();
  }

  @override
  void dispose() {
    dispose();
    super.dispose();
  }
}
