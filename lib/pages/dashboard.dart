import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:tasks/core/controllers/tasks_controller.dart';
import 'package:tasks/core/notifiers/darkmode_notifier.dart';
import 'package:tasks/widgets/tasks_widget.dart';

class Dashboard extends ConsumerWidget {
  Dashboard({super.key});

  final TasksController tasks =
      Get.put(TasksController(1), tag: "tags in progress");

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
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: dark ? Colors.grey[900] : null,
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
              Expanded(child: TasksWidget(tasks: tasks)),
            ],
          ),
        ),
      ),
    );
  }
}
