/* Developed by Eng Mouaz M AlShahmeh */
import 'package:brick_breaker_flutter_game/base/injection/general_injection.dart';
import 'package:brick_breaker_flutter_game/base/language/language.dart';
import 'package:brick_breaker_flutter_game/base/style/color_extension.dart';
import 'package:brick_breaker_flutter_game/base/style/colors.dart';
import 'package:brick_breaker_flutter_game/base/style/theme.dart';
import 'package:brick_breaker_flutter_game/base/widget/bubble.dart';
import 'package:brick_breaker_flutter_game/controller/audio_controller.dart';
import 'package:brick_breaker_flutter_game/controller/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SettingsController _settingsController;
  late AudioController _audioController;

  @override
  void initState() {
    super.initState();
    _audioController = Get.put(getIt<AudioController>());
    _settingsController = Get.put(getIt<SettingsController>());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Center(
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
                  MessageKeys.settingsButtonTitleKey.tr,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: Theme.of(context).colorScheme.primaryMainColor,
                      fontSize: 36),
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    GestureDetector(
                        onTap: () => _triggerAudio(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => Text(
                                  (_settingsController.audioState.value == true)
                                      ? MessageKeys.musicButtonTitleKey.tr +
                                          "    " +
                                          MessageKeys.onButtonTitleKey.tr
                                      : MessageKeys.musicButtonTitleKey.tr +
                                          "    " +
                                          MessageKeys.offButtonTitleKey.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryMainColor,
                                          fontSize: 30)),
                            ),
                            Obx(() => Icon(
                                  (_settingsController.audioState.value == true)
                                      ? Icons.music_note
                                      : Icons.music_off,
                                  color:
                                      Theme.of(context).colorScheme.primaryMainColor,
                                  size: 30,
                                ))
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () => _triggerDarkMode(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => Text(
                                (_settingsController.isDarkTheme.value == true)
                                    ? MessageKeys.darkModeButtonTitleKey.tr +
                                        "    " +
                                        MessageKeys.onButtonTitleKey.tr
                                    : MessageKeys.darkModeButtonTitleKey.tr +
                                        "    " +
                                        MessageKeys.offButtonTitleKey.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryMainColor,
                                        fontSize: 30)),
                          ),
                          Obx(() => Icon(
                                (_settingsController.isDarkTheme.value == true)
                                    ? Icons.dark_mode
                                    : Icons.light_mode,
                                color: Theme.of(context).colorScheme.primaryMainColor,
                                size: 30,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _triggerAudio() {
    _settingsController.saveAudioState(!_settingsController.isAudioEnabled());
    if (!_settingsController.isAudioEnabled()) {
      _audioController.stopAllGameAudio();
      _audioController.stopMusicAudio();
    } else {
      _audioController.playMusicAudio();
    }
  }

  void _triggerDarkMode() {
    if (_settingsController.isThemeDark()) {
      Get.changeTheme(CustomTheme.lightTheme);
      _changeStatusBarColor(AppColors.whiteColor, Brightness.dark);
    } else {
      Get.changeTheme(CustomTheme.darkTheme);
      _changeStatusBarColor(AppColors.blackColor, Brightness.light);
    }
    _settingsController.saveDarkState(!_settingsController.isThemeDark());
  }

  void _changeStatusBarColor(Color statusBarColor, Brightness brightness) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: statusBarColor,
          statusBarIconBrightness: brightness,
          statusBarBrightness: brightness),
    );
  }
}
