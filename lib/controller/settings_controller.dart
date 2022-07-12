/* Developed by Eng Mouaz M AlShahmeh */
import 'package:brick_breaker_flutter_game/base/utils/constants.dart';
import 'package:brick_breaker_flutter_game/base/utils/shared_preference.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {

  SharedPrefs sharedPrefs;

  RxBool audioState = true.obs;

  RxBool isDarkTheme = true.obs;

  SettingsController({required this.sharedPrefs});

  @override
  void onInit() {
    super.onInit();
    audioState = (sharedPrefs.getBool(Constants.audioKey) ?? true).obs;
  }

  bool isAudioEnabled() {
    return sharedPrefs.getBool(Constants.audioKey) ?? true;
  }

  void saveAudioState(bool audioEnabled) {
    audioState.value = audioEnabled;
    sharedPrefs.putBool(Constants.audioKey, audioEnabled);
  }

  bool isThemeDark() {
    return sharedPrefs.getBool(Constants.darkModeKey) ?? true;
  }

  void saveDarkState(bool isDarkMode) {
    isDarkTheme.value = isDarkMode;
    sharedPrefs.putBool(Constants.darkModeKey, isDarkMode);
  }

  @override
  void dispose() {
    audioState.close();
    isDarkTheme.close();
    super.dispose();
  }
}
