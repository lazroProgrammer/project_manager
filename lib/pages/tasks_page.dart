import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks/pages/task_page.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("tasks"),
      ),
      body: Container(
        margin: EdgeInsets.all(0),
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) => ListTile(
            title: Text("Task $index"),
            onTap: () {
              Get.to(
                () => TaskPage(),
                duration: Duration(milliseconds: 400),
                transition: Transition.fade,
              );
            },
          ),
        ),
      ),
    );
  }
}
