/* Developed by Eng Mouaz M AlShahmeh */
import 'package:brick_breaker_flutter_game/base/style/color_extension.dart';
import 'package:flutter/material.dart';

class Award extends StatelessWidget {
  final double awardX;
  final double awardY;
  final bool awardShown;
  final IconData icon;
  final double awardWidth = 20;
  final double awardHeight = 20;

  const Award(
      {Key? key,
      required this.icon,
      required this.awardX,
      required this.awardY,
      required this.awardShown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return awardShown
        ? Container(
            alignment: Alignment(awardX, awardY),
            child: SizedBox(
              width: awardWidth,
              height: awardHeight,
              child: Center(
                  child: Icon(
                icon,
                color: Theme.of(context).colorScheme.gameColor,
              )),
            ),
          )
        : Container();
  }
}
