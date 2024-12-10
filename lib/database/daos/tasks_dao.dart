import 'package:drift/drift.dart';
import 'package:tasks/database/database.dart';

part 'tasks_dao.g.dart';

@DriftAccessor(tables: [Tasks])
class TasksDao extends DatabaseAccessor<AppDatabase> with _$TasksDaoMixin {
  final AppDatabase db;

  // Pass the AppDatabase instance to the DAO
  TasksDao(this.db) : super(db);

  // Define your query functions here

  Future<List<Task>> getAllTask() async {
    return await db.select(db.tasks).get();
  }

  Future<int> insertTask(TasksCompanion task) async {
    return await db.into(db.tasks).insert(task);
  }

  Future<Task?> getTaskByID(int id) async {
    return await (select(db.tasks)..where((tbl) => tbl.taskID.equals(id)))
        .getSingleOrNull();
  }

  Future<List<Task>> getTasksBySegmentID(int segmentID) async {
    return await (select(db.tasks)
          ..where((tbl) => tbl.segmentID.equals(segmentID)))
        .get();
  }

  Future<int> editTaskByID(int id, Map<String, dynamic> updatedFields) async {
    try {
      final updatedCompanion = TasksCompanion(
        taskID: Value(id), // Always include the ID to locate the row
        segmentID: updatedFields.containsKey('segmentID')
            ? Value(updatedFields['segmentID'] as int)
            : const Value.absent(),
        name: updatedFields.containsKey('name')
            ? Value(updatedFields['name'] as String)
            : const Value.absent(),
        description: updatedFields.containsKey('description')
            ? Value(updatedFields['description'] as String)
            : const Value.absent(),
        priority: updatedFields.containsKey('priority')
            ? Value(updatedFields['priority'] as int)
            : const Value.absent(),
        state: updatedFields.containsKey('state')
            ? Value(updatedFields['state'] as String)
            : const Value.absent(),
        startDate: updatedFields.containsKey('startDate')
            ? Value(updatedFields['startDate'] as DateTime?)
            : const Value.absent(),
        completionDate: updatedFields.containsKey('completionDate')
            ? Value(updatedFields['completionDate'] as DateTime?)
            : const Value.absent(),
      );

      // Perform the update operation in the database
      return await (update(db.tasks)..where((tbl) => tbl.taskID.equals(id)))
          .write(updatedCompanion);
    } catch (e) {
      return -1;
    }
  }

  Future<List<Task>> getTasksInProgress() async {
    return await (select(db.tasks)
          ..where(
              (tbl) => tbl.startDate.isNotNull() & tbl.completionDate.isNull()))
        .get();
  }

  Future<int> deleteTaskByID(int id) async {
    return await (delete(db.tasks)..where((tbl) => tbl.taskID.equals(id))).go();
  }
}
