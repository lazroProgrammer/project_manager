import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tasks/database/daos/tasks_dao.dart';
import 'package:tasks/database/database.dart';

class TasksController extends GetxController {
  RxList<Task> tasks = RxList<Task>();
  RxInt segmentID = (-1).obs;

  final TasksDao dao = TasksDao(AppDatabase());
  Logger log = Logger();

  TasksController(int options) {
    switch (options) {
      case -1:
        break;
      case 0:
        getAll();
        break;
      case 1:
        getTasksInProgress();
        break;
      default:
        throw Exception(
            "choose the right option the initialize tasksController");
    }
  }

  Future<void> getAll() async {
    try {
      final result = await dao.getAllTask();
      tasks.assignAll(result);
    } catch (e) {
      log.e('Failed to fetch Tasks: $e');
    }
  }

  Future<void> getTasksBySegmentID(int segmentId) async {
    segmentID = segmentId.obs;
    final result = await dao.getTasksBySegmentID(segmentID.value);
    tasks.assignAll(result);
  }

  Future<void> insertTask(TasksCompanion task) async {
    try {
      final result = await dao.insertTask(task);
      if (result >= 0) {
        final newTask = await dao.getTaskByID(result);
        if (newTask != null) {
          tasks.add(newTask);
          Fluttertoast.showToast(msg: "Task successfully added");
        } else {
          Fluttertoast.showToast(msg: "oops something went wrong");
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to add Tasks");
      log.e('Failed to insert Task: $e');
    }
  }

  Future<void> getTasksInProgress() async {
    try {
      final result = await dao.getTasksInProgress();
      tasks.assignAll(result);
    } catch (e) {
      throw Exception();
    }
  }

  Future<int> deleteTaskById(int id) async {
    try {
      final result = await dao.deleteTaskByID(id);
      if (result > 0) {
        tasks.removeWhere((task) => task.taskID == id);
      }
      return result;
    } catch (e) {
      log.e('Failed to delete Task: $e');
      return -1;
    }
  }
}
