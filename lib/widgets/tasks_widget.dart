import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:tasks/core/controllers/tasks_controller.dart';
import 'package:tasks/core/controllers/todo_controller.dart';
import 'package:tasks/core/notifiers/darkmode_notifier.dart';
import 'package:tasks/database/database.dart';
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
              showPopupMenu(
                context,
                posKeys[index],
                edit: () {
                  showTaskstAddForum(
                    context,
                    ref,
                    tasks,
                    task: tasks.tasks[index],
                  );
                },
                delete: () {
                  tasks.deleteTaskById(tasks.tasks[index].taskID);
                },
              );
            },
            onTap: () {
              TodoController todos = Get.put(
                TodoController(),
                tag: "tasks/todos",
              );
              todos.getTodosBytaskID(tasks.tasks[index]);
              Get.to(
                () => TaskPage(taskCtrller: tasks, taskIndex: index),
                duration: const Duration(milliseconds: 400),
                transition: Transition.fade,
              );
            },
            child: AnimatedTaskItem(
              task: tasks.tasks[index],
              isDarkMode: dark,
              onToggleCompletion: () {
                final isComplete = tasks.tasks[index].completionDate != null;
                tasks.toggleTaskCompletion(index, !isComplete);
              },
              onTogglePlay: () {
                final isPlayed = tasks.tasks[index].startDate != null;
                tasks.togglePlayTask(index, !isPlayed);
              },
            ),
          );
        },
      );
    });
  }
}

class AnimatedTaskItem extends StatelessWidget {
  const AnimatedTaskItem({
    super.key,
    required this.task,
    required this.isDarkMode,
    required this.onToggleCompletion,
    required this.onTogglePlay,
  });

  final Task task;
  final bool isDarkMode;
  final VoidCallback onToggleCompletion;
  final VoidCallback onTogglePlay;

  @override
  Widget build(BuildContext context) {
    final isComplete = task.completionDate != null;

    return AnimatedContainer(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8),
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
      color:
          isComplete
              ? (isDarkMode ? Colors.green[700] : Colors.green[100])
              : Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TweenAnimationBuilder(
              curve: Curves.easeInOut,
              tween: Tween<double>(
                begin: 0,
                end: task.completionDate != null ? 2 : 0,
              ),
              duration: const Duration(milliseconds: 400),
              builder: (context, value, child) {
                return Transform.rotate(
                  angle: value * 3.14,
                  child: Opacity(
                    opacity: (1 - (value % 2)).abs(),
                    child: IconButton(
                      onPressed: onToggleCompletion,
                      icon:
                          isComplete
                              ? Icon(
                                Icons.check_circle_outline,
                                color:
                                    isDarkMode
                                        ? Colors.green[900]
                                        : Colors.green[700],
                                size: 40,
                              )
                              : const Icon(Icons.circle_outlined, size: 36),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Text(
              "Task: ${task.name}",
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child:
                task.completionDate != null
                    ? Container()
                    : TweenAnimationBuilder(
                      curve: Curves.easeInOut,
                      tween: Tween<double>(
                        begin: 0,
                        end: task.startDate != null ? 2 : 0,
                      ),
                      duration: const Duration(milliseconds: 300),
                      builder: (context, value, child) {
                        return Transform.rotate(
                          angle: value * 3.14,
                          child: Opacity(
                            opacity: (1 - (value % 2)).abs(),
                            child: IconButton(
                              onPressed: onTogglePlay,
                              icon: Icon(
                                task.startDate != null
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                size: 30,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
