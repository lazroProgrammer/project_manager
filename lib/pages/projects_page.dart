import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:tasks/core/controllers/click_effect_controller.dart';
import 'package:tasks/core/controllers/projects_controller.dart';
import 'package:tasks/core/controllers/segments_controller.dart';
import 'package:tasks/core/notifiers/darkmode_notifier.dart';
import 'package:tasks/main.dart';
import 'package:tasks/pages/project_page.dart';
import 'package:tasks/theme/app_theme.dart';
import 'package:tasks/widgets/popup_menu.dart';

class ProjectsPage extends ConsumerWidget {
  ProjectsPage({super.key});

  final projects = Get.find<ProjectsController>(tag: "projects");
  final segments = Get.put(SegmentsController(), tag: "project/segments");
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isClickedController =
        Get.find<ClickEffectController>(tag: "projects_clickEffectBools");
    final dark = ref.watch(darkmodeNotifier);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width - 30, 60),
        child: AppBar(
          title: Text("Projects"),
          actions: [
            IconButton(
              onPressed: () {
                ref.read(darkmodeNotifier.notifier).toggleDarkmode(!dark);
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
                            color: dark ? Colors.blue[700] : Colors.yellow[700],
                          ),
                        ));
                  }),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () {
            final projectsList = projects.projects;
            return ListView.builder(
              itemCount: projectsList.length,
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
                            color:
                                (dark) ? context.primaryColor : Colors.white60,
                            child: InkWell(
                              onLongPress: () {
                                showPopupMenu(context, edit: () {}, delete: () {
                                  projects.deleteProjectById(
                                      projects.projects[index].projectID);
                                });
                              },
                              onTapCancel: () =>
                                  isClickedController.buttonEnlarge(index),
                              onTap: () {
                                isClickedController.buttonShrink(index);
                                isClickedController.buttonEnlarge(index);
                                segments.getSegmentsByProjectID(
                                    projects.projects[index].projectID);
                                final segsClicks = Get.put(
                                    ClickEffectController(
                                        segments.segments.length),
                                    tag: "segments_click_effect");
                                ever(segments.segments, (segs) {
                                  segsClicks.updateLength(segs.length);
                                });
                                Get.to(
                                  () => ProjectPage(),
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
                                margin: EdgeInsets.fromLTRB(20, 16, 20, 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        "Project $index",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10, right: 40, bottom: 10),
                                      child: Text(
                                        "  create a habit builder app, it tracks user sleep, screen time, work time, it tracks the mood of the user and show different charts for different things...",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: dark
                                              ? Colors
                                                  .grey[300] // For dark mode
                                              : Colors.grey[900],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "state: draft",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "12/12/12 - 30/12/12",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
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
            );
          },
        ),
      ),
    );
  }
}
