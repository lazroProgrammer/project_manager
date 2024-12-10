import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tasks/database/daos/projects_dao.dart';
import 'package:tasks/database/database.dart';

class ProjectsController extends GetxController {
  RxList<Project> projects = RxList<Project>();

  final ProjectsDao dao = ProjectsDao(AppDatabase());
  Logger log = Logger();

  Future<void> getAll() async {
    try {
      final result = await dao.getAllProject();
      projects.assignAll(result);
    } catch (e) {
      log.e('Failed to fetch projects: $e');
    }
  }

  Future<void> insertProject(ProjectsCompanion project) async {
    try {
      final result = await dao.insertProject(project);
      if (result >= 0) {
        final newProject = await dao.getProjectById(result);
        if (newProject != null) {
          projects.add(newProject);
          Fluttertoast.showToast(msg: "Project successfully added");
        } else {
          Fluttertoast.showToast(msg: "oops something went wrong");
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to add projects");
      log.e('Failed to insert project: $e');
    }
  }

  Future<int> deleteProjectById(int id) async {
    try {
      final result = await dao.deleteProjectById(id);
      if (result > 0) {
        projects.removeWhere((project) => project.projectID == id);
      }
      return result;
    } catch (e) {
      log.e('Failed to delete project: $e');
      return -1; // Return -1 to indicate failure
    }
  }
}
