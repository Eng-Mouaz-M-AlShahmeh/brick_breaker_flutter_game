/* Developed by Eng Mouaz M AlShahmeh */
import 'package:brick_breaker_flutter_game/base/style/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

class Ball extends StatelessWidget {
  final double ballX;
  final double ballY;
  final bool ballShown;
  final double ballWidth = 15;
  final double ballHeight = 15;

  const Ball(
      {Key? key,
      required this.ballX,
      required this.ballY,
      required this.ballShown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ballShown
        ? Container(
            alignment: Alignment(ballX, ballY),
            child: AvatarGlow(
              endRadius: 15.0,
              child: Container(
                width: ballWidth,
                height: ballHeight,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.gameColor,
                    shape: BoxShape.circle),
              ),
            ),
          )
        : Container();
  }
}
