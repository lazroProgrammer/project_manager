import 'package:drift/drift.dart';
import 'package:tasks/database/database.dart';

part 'todos_dao.g.dart';

extension TodoCompanionExtension on TodosCompanion {
  Map<String, dynamic> toJson() {
    return {
      'todoID': todoID.value,
      'name': name.value,
      'startedAt': startedAt.value,
      'completedAt': completedAt.value,
      'taskID': taskID.value,
    };
  }
}

@DriftAccessor(tables: [Todos])
class TodosDao extends DatabaseAccessor<AppDatabase> with _$TodosDaoMixin {
  final AppDatabase db;

  // Pass the AppDatabase instance to the DAO
  TodosDao(this.db) : super(db);

  // Define your query functions here

  Future<List<Todo>> getAllTodo() async {
    return await db.select(db.todos).get();
  }

  Future<int> insertTodo(TodosCompanion todo) async {
    try {
      return await db.into(db.todos).insertOnConflictUpdate(todo);
    } catch (e) {
      print(e);
      return -1;
    }
  }

  Future<Todo?> getTodoByID(int id) async {
    return await (select(db.todos)
      ..where((tbl) => tbl.todoID.equals(id))).getSingleOrNull();
  }

  Future<List<Todo>> getTodosByTaskID(int taskID) async {
    return await (select(db.todos)
      ..where((tbl) => tbl.taskID.equals(taskID))).get();
  }

  Future<int> editTodoByID(int id, Map<String, dynamic> updatedFields) async {
    try {
      final updatedCompanion = TodosCompanion(
        todoID: Value(id), // Always include the ID to locate the row
        taskID:
            updatedFields.containsKey('taskID')
                ? Value(updatedFields['taskID'] as int)
                : const Value.absent(),
        name:
            updatedFields.containsKey('name')
                ? Value(updatedFields['name'] as String)
                : const Value.absent(),
        completedAt:
            updatedFields.containsKey('completedAt')
                ? Value(updatedFields['completedAt'] as DateTime?)
                : const Value.absent(),
      );

      // Perform the update operation in the database
      return await (update(db.todos)
        ..where((tbl) => tbl.todoID.equals(id))).write(updatedCompanion);
    } catch (e) {
      return -1;
    }
  }

  Future<int> deleteTodoByID(int id) async {
    return await (delete(db.todos)..where((tbl) => tbl.todoID.equals(id))).go();
  }
}
