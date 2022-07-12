/* Developed by Eng Mouaz M AlShahmeh */
import 'package:audioplayers/audioplayers.dart';
import 'package:brick_breaker_flutter_game/base/utils/constants.dart';
import 'package:brick_breaker_flutter_game/base/utils/shared_preference.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AudioController extends GetxController {
  AudioPlayer? _gameOverPlayer,
      _brickPlayer,
      _awardPlayer,
      _missionSuccessPlayer,
      _gamePlayer;

  late SharedPrefs sharedPrefs;

  AudioController({required this.sharedPrefs});

  void playBrickAudio() async {
    if (sharedPrefs.getBool(Constants.audioKey) ?? true) {
      AudioCache audioCache = AudioCache();
      _brickPlayer = await audioCache.play("audio/brick.wav");
    }
  }

  void stopBrickAudio() {
    _brickPlayer?.stop();
  }

  void playGameOverAudio() async {
    if (sharedPrefs.getBool(Constants.audioKey) ?? true) {
      AudioCache audioCache = AudioCache();
      _brickPlayer = await audioCache.play("audio/game_over.wav");
    }
  }

  void stopGameOverAudio() {
    _gameOverPlayer?.stop();
  }

  void playAwardAudio() async {
    if (sharedPrefs.getBool(Constants.audioKey) ?? true) {
      AudioCache audioCache = AudioCache();
      _awardPlayer = await audioCache.play("audio/award.wav");
    }
  }

  void stopAwardAudio() {
    _awardPlayer?.stop();
  }

  void playMissionSuccessAudio() async {
    if (sharedPrefs.getBool(Constants.audioKey) ?? true) {
      AudioCache audioCache = AudioCache();
      _missionSuccessPlayer =
          await audioCache.play("audio/mission_success.wav");
    }
  }

  void stopMissionSuccessAudio() {
    _missionSuccessPlayer?.stop();
  }

  void playMusicAudio() async {
    if (sharedPrefs.getBool(Constants.audioKey) ?? true) {
      AudioCache audioCache = AudioCache();
      _gamePlayer = await audioCache.loop("audio/game.mp3");
    }
  }

  void stopMusicAudio() {
    _gamePlayer?.stop();
  }

  void stopAllGameAudio() {
    stopAwardAudio();
    stopBrickAudio();
    stopGameOverAudio();
    stopMissionSuccessAudio();
  }

  @override
  void dispose() {
    stopMusicAudio();
    stopAwardAudio();
    stopBrickAudio();
    stopGameOverAudio();
    stopMissionSuccessAudio();
    super.dispose();
  }
}
