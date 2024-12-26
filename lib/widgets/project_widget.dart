import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:tasks/core/controllers/click_effect_controller.dart';
import 'package:tasks/core/controllers/segments_controller.dart';
import 'package:tasks/core/controllers/tasks_controller.dart';
import 'package:tasks/core/notifiers/darkmode_notifier.dart';
import 'package:tasks/pages/tasks_page.dart';
import 'package:tasks/theme/app_theme.dart';
import 'package:tasks/widgets/popup_menu.dart';

class ProjectWidget extends ConsumerWidget {
  const ProjectWidget({super.key, required this.segmentsController});
  final SegmentsController segmentsController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = ref.watch(darkmodeNotifier);
    final ClickEffectController isClickedController = Get.find(
      tag: "segments_click_effect",
    );
    final TasksController tasksController = Get.put(
      TasksController(-1),
      tag: "segments/tasks",
    );
    return Obx(() {
      final posKeys = isClickedController.posKeys;
      return GridView.builder(
        itemCount: segmentsController.segments.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
        ),
        itemBuilder: (context, index) {
          return Obx(() {
            final isClicked = isClickedController.clickStates[index];
            return Container(
              key: posKeys[index],
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: AnimatedScale(
                scale: isClicked ? 0.95 : 1.0,
                duration: const Duration(milliseconds: 100),
                child: Card(
                  elevation: (dark) ? 2 : 3,
                  shadowColor:
                      (dark) ? context.primaryColor : context.primaryColor,
                  color: (dark) ? context.primaryColor : Colors.white60,
                  child: InkWell(
                    onLongPress: () {
                      showPopupMenu(
                        context,
                        posKeys[index],
                        edit: () {},
                        delete: () {
                          segmentsController.deleteSegmentById(
                            segmentsController.segments[index].segmentID,
                          );
                        },
                      );
                    },
                    onTapCancel: () => isClickedController.buttonEnlarge(index),
                    onTap: () {
                      isClickedController.buttonShrink(index);
                      isClickedController.buttonEnlarge(index);
                      tasksController.getTasksBySegmentID(
                        segmentsController.segments[index].segmentID,
                      );
                      Get.to(
                        () => TasksPage(),
                        duration: Duration(milliseconds: 400),
                        transition: Transition.fade,
                      );
                    },
                    splashColor:
                        (dark)
                            ? adjustBrightness(
                              context.primaryColor,
                              isDarkMode: dark,
                              brightness: 0.6,
                            )
                            : adjustBrightness(
                              context.primaryColor,
                              isDarkMode: dark,
                              brightness: 0.8,
                            ),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            segmentsController.segments[index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(segmentsController.segments[index].type),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        },
      );
    });
  }
}
