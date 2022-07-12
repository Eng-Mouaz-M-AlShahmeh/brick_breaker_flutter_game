/* Developed by Eng Mouaz M AlShahmeh */
import 'package:flutter/material.dart';

class Brick extends StatelessWidget {
  final double brickX;
  final double brickY;
  final double brickWidth;
  final double brickHeight;
  final int brickBrokenHits;
  final Color mainColor;
  final Color mainColorLight;

  const Brick(
      {Key? key,
      required this.brickX,
      required this.brickY,
      required this.brickWidth,
      required this.brickHeight,
      required this.brickBrokenHits,
      required this.mainColor,
      required this.mainColorLight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return brickBrokenHits == 0
        ? Container()
        : Container(
            alignment:
                Alignment((2 * brickX + brickWidth) / (2 - brickWidth), brickY),
            child: ClipRRect(

              child: Container(
                color: brickBrokenHits == 1 ? mainColorLight : mainColor,
                height: MediaQuery.of(context).size.height * brickHeight / 2,
                width: MediaQuery.of(context).size.width * brickWidth / 2,
              ),
            ),
          );
  }
}
