import 'package:flutter/material.dart';
import 'package:tasks/widgets/darkmode_toggle.dart';
import 'package:tasks/widgets/projects_widget.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width - 30, 60),
        child: AppBar(title: Text("Projects"), actions: [DarkmodeToggle()]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ProjectsWidget(),
      ),
    );
  }
}
