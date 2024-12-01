import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks/core/notifiers/darkmode_notifier.dart';
import 'package:tasks/core/settings.dart';
import 'package:tasks/pages/projects_page.dart';
import 'package:tasks/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  await SettingsData.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const ProviderScope(child: MainApp()));
}

extension CustomColors on BuildContext {
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;
  Color get backgroundColor => Theme.of(this).colorScheme.surface;
  Color get surfaceColor => Theme.of(this).colorScheme.surface;
}

extension CustomTextStyles on BuildContext {
  TextStyle get headline1 => Theme.of(this).textTheme.headlineLarge!;
  TextStyle get bodyText1 => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get caption => Theme.of(this).textTheme.labelLarge!;
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SettingsData();
    final dark = ref.watch(darkmodeNotifier);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: dark ? AppTheme.darkTheme : AppTheme.lightTheme,
      // themeMode: ThemeMode.system,
      home: ProjectsPage(),
    );
  }
}
