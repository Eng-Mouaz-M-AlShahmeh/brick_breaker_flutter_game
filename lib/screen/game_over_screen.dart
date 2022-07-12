/* Developed by Eng Mouaz M AlShahmeh */
import 'package:brick_breaker_flutter_game/base/language/language.dart';
import 'package:brick_breaker_flutter_game/base/style/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              MessageKeys.gameOverTitleKey.tr,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Theme.of(context).colorScheme.primaryMainColor, fontSize: 46),
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back(result: true);
                  },
                  child: Text(
                    MessageKeys.playAgainButtonTitleKey.tr,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Theme.of(context).colorScheme.primaryMainColor,
                        fontSize: 30),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                  child: Text(
                    MessageKeys.backButtonTitleKey.tr,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Theme.of(context).colorScheme.primaryMainColor,
                        fontSize: 30),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
