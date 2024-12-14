import 'package:drift/drift.dart';
import 'package:tasks/database/database.dart';

part 'projects_dao.g.dart';

extension ProjectCompanionExtension on ProjectsCompanion {
  Map<String, dynamic> toJson() {
    return {
      'projectID': projectID.value,
      'name': name.value,
      'description': description.value,
      'state': state.value,
      'createdAt': createdAt.value,
      'startDate': startDate.value,
      'completionDate': completionDate.value,
    };
  }
}

@DriftAccessor(tables: [Projects])
class ProjectsDao extends DatabaseAccessor<AppDatabase>
    with _$ProjectsDaoMixin {
  final AppDatabase db;

  // Pass the AppDatabase instance to the DAO
  ProjectsDao(this.db) : super(db);

  // Define your query functions here

  Future<List<Project>> getAllProject() async {
    try {
      return await db.select(db.projects).get();
    } catch (e, stk) {
      print("$e $stk");
      return [];
    }
  }

  Future<int> insertProject(ProjectsCompanion project) async {
    try {
      return await db.into(db.projects).insertOnConflictUpdate(project);
    } catch (e) {
      return -1;
    }
  }

  Future<Project?> getProjectById(int id) async {
    return await (select(db.projects)..where((tbl) => tbl.projectID.equals(id)))
        .getSingleOrNull();
  }

  Future<int> editProjectByID(
      int id, Map<String, dynamic> updatedFields) async {
    try {
      final updatedCompanion = ProjectsCompanion(
        projectID: Value(id), // Always include the ID to locate the row
        name: updatedFields.containsKey('name')
            ? Value(updatedFields['name'] as String)
            : const Value.absent(),
        description: updatedFields.containsKey('description')
            ? Value(updatedFields['description'] as String)
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
      return await (update(db.projects)
            ..where((tbl) => tbl.projectID.equals(id)))
          .write(updatedCompanion);
    } catch (e) {
      return -1;
    }
  }

  Future<int> deleteProjectById(int id) async {
    try {
      return await (delete(db.projects)
            ..where((tbl) => tbl.projectID.equals(id)))
          .go();
    } catch (e) {
      return -1;
    }
  }
}
