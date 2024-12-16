import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Projects extends Table {
  IntColumn get projectID => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 20)();
  TextColumn get description => text()();
  TextColumn get state => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get completionDate => dateTime().nullable()();
}

class Segments extends Table {
  IntColumn get segmentID => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get state => text()();
  TextColumn get type => text()();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get completionDate => dateTime().nullable()();
  IntColumn get projectID => integer().references(Projects, #projectID)();
}

class Tasks extends Table {
  IntColumn get taskID => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get state => text()();
  IntColumn get priority => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get completionDate => dateTime().nullable()();
  IntColumn get segmentID => integer().references(Segments, #segmentID)();
}

class Todos extends Table {
  IntColumn get todoID => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get startedAt => dateTime().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  IntColumn get taskID => integer().references(Tasks, #taskID)();
}

@DriftDatabase(tables: [Projects, Segments, Tasks, Todos])
class AppDatabase extends _$AppDatabase {
  // Private constructor
  AppDatabase._internal() : super(_openConnection());

  // Singleton instance
  static final AppDatabase _instance = AppDatabase._internal();

  // Public factory constructor
  factory AppDatabase() {
    return _instance;
  }

  @override
  int get schemaVersion => 1;
}

// Database connection function using LazyDatabase
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
    return NativeDatabase(file);
  });
}
