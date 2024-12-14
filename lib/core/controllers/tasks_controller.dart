import 'package:drift/drift.dart' as d;
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
          if (task.taskID == const d.Value.absent()) {
            tasks.add(newTask);
            Fluttertoast.showToast(msg: "Task successfully added");
          } else {
            int index = tasks.indexWhere((p) => p.taskID == task.taskID.value);
            if (index != -1) {
              tasks[index] = newTask;
              Fluttertoast.showToast(msg: "Task successfully updated");
            } else {
              Fluttertoast.showToast(msg: "Task not found");
            }
          }
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

  Future<void> editTask(TasksCompanion task) async {
    final json = task.toJson();
    final result = await dao.editTaskByID(json["taskID"], json);
    if (result >= 0) {
      final newTask = await dao.getTaskByID(result);
      int index = tasks.indexWhere((p) => p.taskID == task.taskID.value);
      if (newTask != null) {
        if (index != -1) {
          tasks[index] = newTask;
          Fluttertoast.showToast(msg: "Task successfully updated");
        } else {
          Fluttertoast.showToast(msg: "Task not found");
        }
      } else {
        Fluttertoast.showToast(msg: "oops, you gotta get something");
      }
    } else {
      Fluttertoast.showToast(msg: "oops something went wrong");
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

  Future<void> togglePlayTask(int index, bool b) async {
    try {
      // Attempt to update the database

      final success = await dao.editTaskByID(
        tasks[index].taskID,
        {"startDate": b ? DateTime.now() : null},
      );

      // If the update was successful, update the in-memory list
      if (success != -1) {
        tasks[index] = tasks[index].copyWith(
          startDate: d.Value<DateTime?>(b ? DateTime.now() : null),
        );
        Fluttertoast.showToast(
            msg: "Task ${tasks[index].taskID} successfully updated.");
      } else {
        Fluttertoast.showToast(
            msg: "Failed to update Task ${tasks[index].taskID}.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error toggling task: $e");
    }
  }

  Future<void> toggleTaskCompletion(int index, bool isComplete) async {
    try {
      // Attempt to update the database
      if (!await dao.areAllTodosCompletedByID(tasks[index].taskID)) {
        Fluttertoast.showToast(msg: "you still have work to do in this task");
      } else {
        if (isComplete) {
          final success = await dao.editTaskByID(
            tasks[index].taskID,
            {"completionDate": isComplete ? DateTime.now() : null},
          );

          // If the update was successful, update the in-memory list
          if (success != -1) {
            tasks[index] = tasks[index].copyWith(
              completionDate:
                  d.Value<DateTime?>(isComplete ? DateTime.now() : null),
            );
            Fluttertoast.showToast(
                msg: "Task ${tasks[index].taskID} successfully completed.");
          } else {
            Fluttertoast.showToast(
                msg: "Failed to update Task ${tasks[index].taskID}.");
          }
        } else {
          final success = await dao.editTaskByID(
            tasks[index].taskID,
            {"completionDate": isComplete ? DateTime.now() : null},
          );
          // If the update was successful, update the in-memory list
          if (success != -1) {
            tasks[index] = tasks[index].copyWith(
              completionDate:
                  d.Value<DateTime?>(isComplete ? DateTime.now() : null),
            );
          }
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error toggling task: $e");
    }
  }
}
