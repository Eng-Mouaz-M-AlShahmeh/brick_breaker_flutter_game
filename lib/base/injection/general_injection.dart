/* Developed by Eng Mouaz M AlShahmeh */
import 'package:brick_breaker_flutter_game/base/utils/shared_preference.dart';
import 'package:brick_breaker_flutter_game/controller/audio_controller.dart';
import 'package:brick_breaker_flutter_game/controller/game_controller.dart';
import 'package:brick_breaker_flutter_game/controller/settings_controller.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initGeneralInjection() async {
  getIt.registerSingletonAsync<SharedPrefs>(() async {
    final sharedPrefs = SharedPrefs();
    await sharedPrefs.init();
    return sharedPrefs;
  });

  await GetIt.instance.isReady<SharedPrefs>().then((_) async {
    getIt.registerFactory<AudioController>(
        () => AudioController(sharedPrefs: getIt<SharedPrefs>()));
    getIt.registerFactory<SettingsController>(
        () => SettingsController(sharedPrefs: getIt<SharedPrefs>()));
    getIt.registerFactory<GameController>(
        () => GameController(sharedPrefs: getIt<SharedPrefs>()));
  });
}
