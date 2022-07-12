/* Developed by Eng Mouaz M AlShahmeh */
import 'package:brick_breaker_flutter_game/base/style/color_extension.dart';
import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  final double playerX;
  final double playerWidth;
  final bool playerShown;

  const Player(
      {Key? key,
      required this.playerWidth,
      required this.playerX,
      required this.playerShown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return playerShown
        ? Container(
            alignment:
                Alignment((2 * playerX + playerWidth) / (2 - playerWidth), 0.9),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Container(
                height: 10,
                width: MediaQuery.of(context).size.width * playerWidth / 2,
                color: Theme.of(context).colorScheme.gameColor,
              ),
            ),
          )
        : Container();
  }
}
