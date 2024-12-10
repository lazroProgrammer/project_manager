import 'package:drift/drift.dart' as d;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tasks/database/daos/todos_dao.dart';
import 'package:tasks/database/database.dart';

class TodoController extends GetxController {
  RxList<Todo> todos = RxList<Todo>();
  Rx<Task> task;
  TodoController(Task t) : task = t.obs;

  final TodosDao dao = TodosDao(AppDatabase());
  Logger log = Logger();

  Future<void> getAll() async {
    try {
      final result = await dao.getAllTodo();
      todos.assignAll(result);
    } catch (e) {
      log.e('Failed to fetch Todos: $e');
    }
  }

  Future<void> getTodosBytaskID(Task task) async {
    this.task = task.obs;
    final result = await dao.getTodosByTaskID(task.taskID);
    todos.assignAll(result);
  }

  Future<void> insertTodo(TodosCompanion todo) async {
    try {
      final result = await dao.insertTodo(todo);
      if (result >= 0) {
        final newTodo = await dao.getTodoByID(result);
        if (newTodo != null) {
          todos.add(newTodo);
          Fluttertoast.showToast(msg: "Todo successfully added");
        } else {
          Fluttertoast.showToast(msg: "oops something went wrong");
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to add Todos");
      log.e('Failed to insert Todo: $e');
    }
  }

  Future<int> deleteTodoById(int id) async {
    try {
      final result = await dao.deleteTodoByID(id);
      if (result > 0) {
        todos.removeWhere((todo) => todo.todoID == id);
      }
      return result;
    } catch (e) {
      log.e('Failed to delete Todo: $e');
      return -1;
    }
  }

  Future<void> toggleTodo(int index, bool b) async {
    try {
      // Attempt to update the database
      final success = await dao.editTodoByID(
        todos[index].todoID,
        {"completedAt": b ? DateTime.now() : null},
      );

      // If the update was successful, update the in-memory list
      if (success != -1) {
        todos[index] = todos[index].copyWith(
          completedAt: d.Value<DateTime?>(b ? DateTime.now() : null),
        );
        Fluttertoast.showToast(
            msg: "Todo ${todos[index].todoID} successfully updated.");
      } else {
        Fluttertoast.showToast(
            msg: "Failed to update Todo ${todos[index].todoID}.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error toggling todo: $e");
    }
  }
}
