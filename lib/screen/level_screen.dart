/* Developed by Eng Mouaz M AlShahmeh */
import 'package:brick_breaker_flutter_game/base/injection/general_injection.dart';
import 'package:brick_breaker_flutter_game/base/language/language.dart';
import 'package:brick_breaker_flutter_game/base/style/color_extension.dart';
import 'package:brick_breaker_flutter_game/base/style/colors.dart';
import 'package:brick_breaker_flutter_game/base/utils/constants.dart';
import 'package:brick_breaker_flutter_game/base/widget/bubble.dart';
import 'package:brick_breaker_flutter_game/base/widget/empty_app_bar.dart';
import 'package:brick_breaker_flutter_game/controller/game_controller.dart';
import 'package:brick_breaker_flutter_game/screen/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({Key? key}) : super(key: key);

  @override
  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  late GameController _mainController;

  @override
  void initState() {
    super.initState();
    _mainController = Get.put(getIt<GameController>());
    _mainController.loadLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: Container(
        color: Theme.of(context).cardColor,
        child: Stack(
          children: [
            const Bubbles(
              numberOfBubbles: 40,
              maxBubbleSize: 6.0,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  MessageKeys.gameLevelTitleKey.tr,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Theme.of(context).colorScheme.primaryMainColor,
                      fontSize: 46),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                    child: GetX<GameController>(
                        init: _mainController, //here
                        builder: (controller) {
                          int level = _mainController.level.value;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 8),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4),
                              itemBuilder: (_, index) => GestureDetector(
                                onTap: () => startGame(index + 1, level),
                                child: Card(
                                  shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 0,
                                  child: getCard(index, level),
                                ),
                              ),
                              itemCount: Constants.levels + 1,
                            ),
                          );
                        })),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getCard(int index, int level) {
    if (index == Constants.levels) {
      return Container(
        color: AppColors.offWhiteColor,
        child: Center(
          child: Text(
            ("قريبا..").toString(),
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: (index + 1) <= level
                    ? AppColors.whiteColor
                    : AppColors.greyLightColor,
                fontSize: 20),
          ),
        ),
      );
    } else {
      return Container(
        color: (index + 1) <= level
            ? Theme.of(context).colorScheme.primaryMainColor
            : AppColors.offWhiteColor,
        child: Center(
          child: Text(
            (index + 1).toString(),
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: (index + 1) <= level
                    ? AppColors.whiteColor
                    : AppColors.greyLightColor,
                fontSize: 40),
          ),
        ),
      );
    }
  }

  void startGame(int index, int level) {
    if (index == Constants.levels + 1) {
      return;
    } else if (index <= level) {
      Get.to(
        () => GameScreen(
          level: index,
        ),
      );
    }
  }
}
