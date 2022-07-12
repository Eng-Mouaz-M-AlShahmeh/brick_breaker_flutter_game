/* Developed by Eng Mouaz M AlShahmeh */
import 'package:get/get.dart';

class MessageKeys {
  static const String brickBreakerTitleKey = "brickBreakerTitleKey";
  static const String playButtonTitleKey = 'playButtonTitleKey';
  static const String settingsButtonTitleKey = 'settingsButtonTitleKey';
  static const String musicButtonTitleKey = 'musicButtonTitleKey';
  static const String onButtonTitleKey = 'onButtonTitleKey';
  static const String offButtonTitleKey = 'offButtonTitleKey';
  static const String darkModeButtonTitleKey = 'darkModeButtonTitleKey';
  static const String gameLevelTitleKey = 'gameLevelTitleKey';
  static const String levelTitleKey = 'levelTitleKey';
  static const String nextButtonTitleKey = 'nextButtonTitleKey';
  static const String playAgainButtonTitleKey = 'playAgainButtonTitleKey';
  static const String backButtonTitleKey = 'backButtonTitleKey';
  static const String gameOverTitleKey = 'gameOverTitleKey';
  static const String congratulationTitleKey = 'congratulationTitleKey';
  static const String downloadNowTitleKey = 'downloadNowTitleKey';
  static const String rateTitleKey = 'rateTitleKey';
  static const String rateDescKey = 'rateDescKey';
  static const String rateButtonTitleKey = 'rateButtonTitleKey';
  static const String rateNoThanksButtonTitleKey = 'rateNoThanksButtonTitleKey';
  static const String rateMaybeButtonTitleKey = 'rateMaybeButtonTitleKey';
}

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': {
          MessageKeys.brickBreakerTitleKey: 'كسارة الطوب',
          MessageKeys.playButtonTitleKey: 'العب',
          MessageKeys.settingsButtonTitleKey: 'الاعدادات',
          MessageKeys.musicButtonTitleKey: 'موسيقا',
          MessageKeys.darkModeButtonTitleKey: 'الوضع الليلي',
          MessageKeys.gameLevelTitleKey: 'مستوى اللعبة',
          MessageKeys.levelTitleKey: 'المرحلة ',
          MessageKeys.playAgainButtonTitleKey: 'حاول مرة اخرى؟',
          MessageKeys.backButtonTitleKey: 'رجوع',
          MessageKeys.gameOverTitleKey: 'انتهت اللعبة',
          MessageKeys.congratulationTitleKey: 'لقد ربحت',
          MessageKeys.nextButtonTitleKey: 'التالي؟',
          MessageKeys.onButtonTitleKey: 'تشغيل',
          MessageKeys.offButtonTitleKey: 'ايقاف',
          MessageKeys.downloadNowTitleKey: 'حمل الان',
          MessageKeys.rateTitleKey: 'قيم التطبيق',
          MessageKeys.rateMaybeButtonTitleKey: 'لاحقا',
          MessageKeys.rateDescKey:
              'اذا احببت اللعبة، من فضلك خذ جزءا من وقتك لمراجعتها، هذا حقا يساعدنا ولا يتوجب عليك لاكثر من دقيقة لعمل ذلك.',
          MessageKeys.rateButtonTitleKey: 'قيم',
          MessageKeys.rateNoThanksButtonTitleKey: 'لا شكراً'
        },
        'en': {
          MessageKeys.brickBreakerTitleKey: 'BRICK BREAKER',
          MessageKeys.playButtonTitleKey: 'Play',
          MessageKeys.settingsButtonTitleKey: 'Settings',
          MessageKeys.musicButtonTitleKey: 'Music',
          MessageKeys.darkModeButtonTitleKey: 'Dark Mode',
          MessageKeys.gameLevelTitleKey: 'Game Level',
          MessageKeys.levelTitleKey: 'Level ',
          MessageKeys.playAgainButtonTitleKey: 'Play Again?',
          MessageKeys.backButtonTitleKey: 'Back',
          MessageKeys.gameOverTitleKey: 'Game Over',
          MessageKeys.congratulationTitleKey: 'You Win',
          MessageKeys.nextButtonTitleKey: 'Next?',
          MessageKeys.onButtonTitleKey: 'ON',
          MessageKeys.offButtonTitleKey: 'OFF',
          MessageKeys.downloadNowTitleKey: 'Download Now',
          MessageKeys.rateTitleKey: 'Rate this app',
          MessageKeys.rateMaybeButtonTitleKey: 'LATER',
          MessageKeys.rateDescKey:
          'If you like this game, please take a little bit of your time to review it !\nIt really helps us and it should not take you more than one minute.',
          MessageKeys.rateButtonTitleKey: 'RATE',
          MessageKeys.rateNoThanksButtonTitleKey: 'NO THANKS'
        }
      };
}
