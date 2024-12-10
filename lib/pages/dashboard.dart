import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:tasks/core/controllers/dark_mode_controller.dart';
import 'package:tasks/core/controllers/tasks_controller.dart';
import 'package:tasks/core/controllers/todo_controller.dart';
import 'package:tasks/core/notifiers/darkmode_notifier.dart';
import 'package:tasks/pages/task_page.dart';

class Dashboard extends ConsumerWidget {
  Dashboard({super.key});

  final TasksController tasks =
      Get.put(TasksController(1), tag: "tags in progress");
  final ToggleController toggle = Get.put(ToggleController(), tag: "toggle");
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = ref.watch(darkmodeNotifier);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width - 30, 60),
        child: AppBar(
          title: Text("Dashboard"),
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
                            color: dark ? Colors.blue[700] : Colors.yellow[700],
                          ),
                        ));
                  }),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[900],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                " Started Tasks:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: tasks.tasks.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        TodoController todos = Get.put(
                            TodoController(tasks.tasks[index]),
                            tag: "tasks/todos");
                        todos.getTodosBytaskID(tasks.tasks[index]);
                        Get.to(
                          () => TaskPage(),
                          duration: Duration(milliseconds: 400),
                          transition: Transition.fade,
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(8),
                        color: (tasks.tasks[index].completionDate == null)
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
                              child: (tasks.tasks[index].completionDate == null)
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
                            Expanded(
                                child: Text(
                              "Task ${index + 1}: ${tasks.tasks[index].name}",
                              style: TextStyle(fontSize: 18),
                            )),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: tasks.tasks[index].completionDate != null
                                  ? Container()
                                  : Obx(() {
                                      final isPlayed = toggle.isPlayed.value;
                                      return IconButton(
                                        onPressed: () {
                                          toggle.toggle();
                                        },
                                        icon: TweenAnimationBuilder(
                                            curve: Easing.legacy,
                                            tween: Tween<double>(
                                                begin: 0,
                                                end: isPlayed ? 0 : 2),
                                            duration: const Duration(
                                                milliseconds: 80),
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
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
