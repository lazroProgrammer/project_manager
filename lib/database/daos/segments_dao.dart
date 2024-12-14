import 'package:drift/drift.dart';
import 'package:tasks/database/database.dart';

part 'segments_dao.g.dart';

extension SegmentCompanionExtension on SegmentsCompanion {
  Map<String, dynamic> toJson() {
    return {
      'segmentID': segmentID.value,
      'name': name.value,
      'state': state.value,
      'type': type.value,
      'startDate': startDate.value,
      'completionDate': completionDate.value,
      'projectID': projectID.value,
    };
  }
}

@DriftAccessor(tables: [Segments])
class SegmentsDao extends DatabaseAccessor<AppDatabase>
    with _$SegmentsDaoMixin {
  final AppDatabase db;

  // Pass the AppDatabase instance to the DAO
  SegmentsDao(this.db) : super(db);

  // Define your query functions here

  Future<List<Segment>> getAllSegment() async {
    return await db.select(db.segments).get();
  }

  Future<int> insertSegment(SegmentsCompanion segment) async {
    return await db.into(db.segments).insertOnConflictUpdate(segment);
  }

  Future<Segment?> getSegmentByID(int id) async {
    return await (select(db.segments)..where((tbl) => tbl.segmentID.equals(id)))
        .getSingleOrNull();
  }

  Future<List<Segment>> getSegmentsByProjectID(int projectID) async {
    return await (select(db.segments)
          ..where((tbl) => tbl.projectID.equals(projectID)))
        .get();
  }

  Future<int> editSegmentByID(
      int id, Map<String, dynamic> updatedFields) async {
    try {
      final updatedCompanion = SegmentsCompanion(
        segmentID: Value(id), // Always include the ID to locate the row
        projectID: updatedFields.containsKey('projectID')
            ? Value(updatedFields['projectID'] as int)
            : const Value.absent(),
        name: updatedFields.containsKey('name')
            ? Value(updatedFields['name'] as String)
            : const Value.absent(),
        type: updatedFields.containsKey('type')
            ? Value(updatedFields['type'] as String)
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
      return await (update(db.segments)
            ..where((tbl) => tbl.segmentID.equals(id)))
          .write(updatedCompanion);
    } catch (e) {
      return -1;
    }
  }

  Future<int> deleteSegmentByID(int id) async {
    return await (delete(db.segments)..where((tbl) => tbl.segmentID.equals(id)))
        .go();
  }
}
