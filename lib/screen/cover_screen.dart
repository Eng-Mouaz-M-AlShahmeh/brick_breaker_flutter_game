/* Developed by Eng Mouaz M AlShahmeh */
import 'dart:io';
import 'package:brick_breaker_flutter_game/base/injection/general_injection.dart';
import 'package:brick_breaker_flutter_game/base/language/language.dart';
import 'package:brick_breaker_flutter_game/base/style/color_extension.dart';
import 'package:brick_breaker_flutter_game/base/utils/constants.dart';
import 'package:brick_breaker_flutter_game/base/widget/empty_app_bar.dart';
import 'package:brick_breaker_flutter_game/controller/audio_controller.dart';
import 'package:brick_breaker_flutter_game/screen/settings_screen.dart';
import '../base/widget/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'level_screen.dart';

class CoverScreen extends StatefulWidget {
  const CoverScreen({Key? key}) : super(key: key);

  @override
  _CoverScreenState createState() => _CoverScreenState();
}

class _CoverScreenState extends State<CoverScreen> {
  late final AudioController _audioController;

  @override
  void initState() {
    super.initState();
    _showRateDialog();
    _audioController = Get.put(getIt<AudioController>());
    _audioController.playMusicAudio();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _audioController.stopMusicAudio();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: EmptyAppBar(),
        body: Container(
          color: Theme.of(context).cardColor,
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              const Bubbles(
                numberOfBubbles: 40,
                maxBubbleSize: 6.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    MessageKeys.brickBreakerTitleKey.tr,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Theme.of(context).colorScheme.primaryMainColor,
                        fontSize: 36),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  GestureDetector(
                      onTap: _startGame,
                      child: Text(
                        MessageKeys.playButtonTitleKey.tr,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Theme.of(context).colorScheme.primaryMainColor,
                            fontSize: 30),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: _openSettings,
                    child: Text(
                      MessageKeys.settingsButtonTitleKey.tr,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Theme.of(context).colorScheme.primaryMainColor,
                          fontSize: 30),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _share,
                        child: Icon(
                          Icons.share,
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startGame() {
    Get.to(() => const LevelScreen());
  }

  void _openSettings() {
    Get.to(() => const SettingsScreen());
  }

  void _share() {
    FlutterShare.share(
        title: MessageKeys.brickBreakerTitleKey.tr,
        text: MessageKeys.downloadNowTitleKey.tr,
        linkUrl: 'https://play.google.com/store/apps/details?id=' +
            Constants.packageName,
        chooserTitle: MessageKeys.brickBreakerTitleKey.tr);
  }

  void _showRateDialog() {
    RateMyApp rateMyApp = RateMyApp(
      minDays: 4,
      minLaunches: 5,
      remindDays: 5,
      remindLaunches: 5,
      googlePlayIdentifier: Constants.packageName,
    );

    rateMyApp.init().then((_) {
      if (rateMyApp.shouldOpenDialog) {
        rateMyApp.showRateDialog(
          context,
          title: MessageKeys.rateTitleKey.tr,
          // The dialog title.
          message: MessageKeys.rateDescKey.tr,
          // The dialog message.
          rateButton: MessageKeys.rateButtonTitleKey.tr,
          noButton: MessageKeys.rateNoThanksButtonTitleKey.tr,
          laterButton: MessageKeys.rateMaybeButtonTitleKey.tr,
          listener: (button) {
            return true; // Return false if you want to cancel the click event.
          },
          ignoreNativeDialog: Platform.isAndroid,
          // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
          dialogStyle: const DialogStyle(
              titleStyle: TextStyle(fontFamily: ''), messageStyle: TextStyle(fontFamily: ''),),
          // Custom dialog styles.
          onDismissed: () => rateMyApp.callEvent(RateMyAppEventType
              .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
        );
      }
    });
  }

  @override
  void dispose() {
    _audioController.dispose();
    super.dispose();
  }
}
