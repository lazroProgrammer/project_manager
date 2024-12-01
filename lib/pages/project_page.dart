import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:tasks/core/controllers/click_effect_controller.dart';
import 'package:tasks/core/notifiers/darkmode_notifier.dart';
import 'package:tasks/main.dart';
import 'package:tasks/pages/tasks_page.dart';
import 'package:tasks/theme/app_theme.dart';

class ProjectPage extends ConsumerWidget {
  ProjectPage({super.key, required this.projectIndex});
  final int projectIndex;

  final List<String> names = [
    "Drift Database",
    "UI/UX Design",
    "State management using riverpod + Getx",
    "Write Tests",
    "Add some Polish",
    "Complete Deployement"
  ];

  final isClickedController = Get.put(ClickEffectController(6));
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = ref.watch(darkmodeNotifier);
    return Scaffold(
      appBar: AppBar(
        title: Text("Project $projectIndex"),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(darkmodeNotifier.notifier).toggleDarkmode(dark);
            },
            icon: TweenAnimationBuilder(
                curve: Easing.legacyAccelerate,
                tween: Tween<double>(begin: 0, end: dark ? 0 : 2),
                duration: const Duration(milliseconds: 500),
                builder: (context, value, child) {
                  return Transform.rotate(
                      angle: value * 3.14, // Rotation animation
                      child: Opacity(
                        opacity: (1 - (value % 2)).abs(), // Fading effect
                        child: Icon(
                          dark ? Icons.dark_mode : Icons.light_mode,
                          size: 30,
                          color: dark ? Colors.blue[500] : Colors.yellow[700],
                        ),
                      ));
                }),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.9),
          itemBuilder: (context, index) {
            return Obx(
              () {
                final isClicked = isClickedController.clickStates[index];
                return Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: AnimatedScale(
                    scale: isClicked ? 0.95 : 1.0,
                    duration: const Duration(milliseconds: 100),
                    child: Card(
                        elevation: (dark) ? 2 : 3,
                        shadowColor: (dark)
                            ? context.primaryColor
                            // : Theme.of(context).primaryColor,
                            : context.primaryColor,
                        color: (dark) ? context.primaryColor : Colors.white60,
                        child: InkWell(
                          onTapUp: (details) =>
                              isClickedController.buttonShrink(index),
                          onLongPress: () =>
                              isClickedController.buttonShrink(index),
                          onTapCancel: () =>
                              isClickedController.buttonEnlarge(index),
                          onTap: () {
                            isClickedController.buttonShrink(index);
                            isClickedController.buttonEnlarge(index);
                            Get.to(
                              () => TasksPage(),
                              duration: Duration(milliseconds: 400),
                              transition: Transition.fade,
                            );
                          },
                          splashColor: (dark)
                              ? adjustBrightness(context.primaryColor,
                                  isDarkMode: dark, brightness: 0.6)
                              : adjustBrightness(context.primaryColor,
                                  isDarkMode: dark, brightness: 0.8),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  names[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        )),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
