import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:tasks/core/controllers/tasks_controller.dart';
import 'package:tasks/core/controllers/todo_controller.dart';
import 'package:tasks/core/notifiers/darkmode_notifier.dart';
import 'package:tasks/pages/task_page.dart';
import 'package:tasks/pages/tasks_page.dart';
import 'package:tasks/widgets/popup_menu.dart';

class TasksWidget extends ConsumerWidget {
  const TasksWidget({super.key, required this.tasks});
  final TasksController tasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = ref.watch(darkmodeNotifier);
    return Obx(() {
      final posKeys = List.generate(tasks.tasks.length, (_) => GlobalKey());
      return ListView.builder(
          itemCount: tasks.tasks.length,
          itemBuilder: (context, index) {
            return InkWell(
              key: posKeys[index],
              onLongPress: () {
                showPopupMenu(context, posKeys[index], edit: () {
                  showTaskstAddForum(context, ref, tasks,
                      task: tasks.tasks[index]);
                }, delete: () {
                  tasks.deleteTaskById(tasks.tasks[index].taskID);
                });
              },
              onTap: () {
                TodoController todos =
                    Get.put(TodoController(), tag: "tasks/todos");
                todos.getTodosBytaskID(tasks.tasks[index]);
                Get.to(
                  () => TaskPage(
                    taskCtrller: tasks,
                    taskIndex: index,
                  ),
                  duration: Duration(milliseconds: 400),
                  transition: Transition.fade,
                );
              },
              child: Obx(() {
                final isComplete = tasks.tasks[index].completionDate != null;
                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(8),
                  color: (!isComplete)
                      ? null
                      : dark
                          ? Colors.green[700]
                          : Colors.green[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(
                          onPressed: () {
                            tasks.toggleTaskCompletion(index, !isComplete);
                          },
                          icon: (!isComplete)
                              ? Icon(
                                  Icons.circle_outlined,
                                  size: 36,
                                )
                              : Icon(
                                  Icons.check_circle_outline,
                                  color: dark
                                      ? Colors.green[900]!
                                      : Colors.green[700],
                                  size: 40,
                                ),
                        ),
                      ),
                      Expanded(
                          child: Text(
                        "Task ${index + 1}: ${tasks.tasks[index].name}",
                        style: TextStyle(fontSize: 18),
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: tasks.tasks[index].completionDate != null
                            ? Container()
                            : Obx(() {
                                final isPlayed =
                                    tasks.tasks[index].startDate != null;
                                return IconButton(
                                  onPressed: () {
                                    tasks.togglePlayTask(index, !isPlayed);
                                  },
                                  icon: TweenAnimationBuilder(
                                      curve: Easing.legacy,
                                      tween: Tween<double>(
                                          begin: 0, end: isPlayed ? 0 : 2),
                                      duration:
                                          const Duration(milliseconds: 80),
                                      builder: (context, value, child) {
                                        return Transform.rotate(
                                            angle: value *
                                                3.14, // Rotation animation
                                            child: Opacity(
                                              opacity: (1 - (value % 2))
                                                  .abs(), // Fading effect
                                              child: Icon(
                                                isPlayed
                                                    ? Icons.pause
                                                    : Icons.play_arrow,
                                                size: 30,
                                              ),
                                            ));
                                      }),
                                );
                              }),
                      ),
                    ],
                  ),
                );
              }),
            );
          });
    });
  }
}
