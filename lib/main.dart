import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks/core/controllers/click_effect_controller.dart';
import 'package:tasks/core/controllers/projects_controller.dart';
import 'package:tasks/core/notifiers/darkmode_notifier.dart';
import 'package:tasks/core/settings.dart';
import 'package:tasks/pages/main_page.dart';
import 'package:tasks/theme/app_theme.dart';

//TODO: fix updates problems
//TODO: fix shared preferences storage not stored or something
//TODO: write tests to learn at least unit testing
//TODO: more animations
//TODO: learn to deploy an app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  await SettingsData.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final projectsController = Get.put(ProjectsController(), tag: "projects");
  await projectsController.getAll();
  final isClickedController = Get.put(
    ClickEffectController(projectsController.projects.length),
    tag: "projects_clickEffectBools",
  );

  // Setup synchronization between projects and click states
  ever(projectsController.projects, (projects) {
    isClickedController.updateLength(projects.length);
  });
  runApp(const ProviderScope(child: MainApp()));
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
      home: MainPage(),
    );
  }
}
