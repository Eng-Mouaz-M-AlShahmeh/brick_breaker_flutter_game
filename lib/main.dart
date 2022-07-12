/* Developed by Eng Mouaz M AlShahmeh */
import 'package:brick_breaker_flutter_game/base/injection/general_injection.dart';
import 'package:brick_breaker_flutter_game/base/language/language.dart';
import 'package:brick_breaker_flutter_game/base/style/theme.dart';
import 'package:brick_breaker_flutter_game/controller/settings_controller.dart';
import 'package:brick_breaker_flutter_game/screen/cover_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await initGeneralInjection();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  late final SettingsController _settingsController;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    _settingsController = Get.put(GetIt.instance<SettingsController>());

  }

  @override
  Widget build(BuildContext context) {
    setLocale(const Locale("ar"));
    return GetMaterialApp(
      locale: _locale,
      translations: Language(),
      home: const CoverScreen(),
      theme: _settingsController.isThemeDark()
          ? CustomTheme.darkTheme
          : CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
    );
  }

  @override
  void dispose() {
    _settingsController.dispose();
    super.dispose();
  }
}
