// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ProjectsTable extends Projects with TableInfo<$ProjectsTable, Project> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _projectIDMeta =
      const VerificationMeta('projectID');
  @override
  late final GeneratedColumn<int> projectID = GeneratedColumn<int>(
      'project_i_d', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
      'state', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _completionDateMeta =
      const VerificationMeta('completionDate');
  @override
  late final GeneratedColumn<DateTime> completionDate =
      GeneratedColumn<DateTime>('completion_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        projectID,
        name,
        description,
        state,
        createdAt,
        startDate,
        completionDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'projects';
  @override
  VerificationContext validateIntegrity(Insertable<Project> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('project_i_d')) {
      context.handle(
          _projectIDMeta,
          projectID.isAcceptableOrUnknown(
              data['project_i_d']!, _projectIDMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('completion_date')) {
      context.handle(
          _completionDateMeta,
          completionDate.isAcceptableOrUnknown(
              data['completion_date']!, _completionDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {projectID};
  @override
  Project map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Project(
      projectID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}project_i_d'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      state: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date']),
      completionDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}completion_date']),
    );
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }
}

class Project extends DataClass implements Insertable<Project> {
  final int projectID;
  final String name;
  final String description;
  final String state;
  final DateTime createdAt;
  final DateTime? startDate;
  final DateTime? completionDate;
  const Project(
      {required this.projectID,
      required this.name,
      required this.description,
      required this.state,
      required this.createdAt,
      this.startDate,
      this.completionDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['project_i_d'] = Variable<int>(projectID);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['state'] = Variable<String>(state);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || completionDate != null) {
      map['completion_date'] = Variable<DateTime>(completionDate);
    }
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      projectID: Value(projectID),
      name: Value(name),
      description: Value(description),
      state: Value(state),
      createdAt: Value(createdAt),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      completionDate: completionDate == null && nullToAbsent
          ? const Value.absent()
          : Value(completionDate),
    );
  }

  factory Project.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Project(
      projectID: serializer.fromJson<int>(json['projectID']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      state: serializer.fromJson<String>(json['state']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      completionDate: serializer.fromJson<DateTime?>(json['completionDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'projectID': serializer.toJson<int>(projectID),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'state': serializer.toJson<String>(state),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'completionDate': serializer.toJson<DateTime?>(completionDate),
    };
  }

  Project copyWith(
          {int? projectID,
          String? name,
          String? description,
          String? state,
          DateTime? createdAt,
          Value<DateTime?> startDate = const Value.absent(),
          Value<DateTime?> completionDate = const Value.absent()}) =>
      Project(
        projectID: projectID ?? this.projectID,
        name: name ?? this.name,
        description: description ?? this.description,
        state: state ?? this.state,
        createdAt: createdAt ?? this.createdAt,
        startDate: startDate.present ? startDate.value : this.startDate,
        completionDate:
            completionDate.present ? completionDate.value : this.completionDate,
      );
  Project copyWithCompanion(ProjectsCompanion data) {
    return Project(
      projectID: data.projectID.present ? data.projectID.value : this.projectID,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      state: data.state.present ? data.state.value : this.state,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      completionDate: data.completionDate.present
          ? data.completionDate.value
          : this.completionDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Project(')
          ..write('projectID: $projectID, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('state: $state, ')
          ..write('createdAt: $createdAt, ')
          ..write('startDate: $startDate, ')
          ..write('completionDate: $completionDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(projectID, name, description, state,
      createdAt, startDate, completionDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Project &&
          other.projectID == this.projectID &&
          other.name == this.name &&
          other.description == this.description &&
          other.state == this.state &&
          other.createdAt == this.createdAt &&
          other.startDate == this.startDate &&
          other.completionDate == this.completionDate);
}

class ProjectsCompanion extends UpdateCompanion<Project> {
  final Value<int> projectID;
  final Value<String> name;
  final Value<String> description;
  final Value<String> state;
  final Value<DateTime> createdAt;
  final Value<DateTime?> startDate;
  final Value<DateTime?> completionDate;
  const ProjectsCompanion({
    this.projectID = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.state = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.startDate = const Value.absent(),
    this.completionDate = const Value.absent(),
  });
  ProjectsCompanion.insert({
    this.projectID = const Value.absent(),
    required String name,
    required String description,
    required String state,
    required DateTime createdAt,
    this.startDate = const Value.absent(),
    this.completionDate = const Value.absent(),
  })  : name = Value(name),
        description = Value(description),
        state = Value(state),
        createdAt = Value(createdAt);
  static Insertable<Project> custom({
    Expression<int>? projectID,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? state,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? startDate,
    Expression<DateTime>? completionDate,
  }) {
    return RawValuesInsertable({
      if (projectID != null) 'project_i_d': projectID,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (state != null) 'state': state,
      if (createdAt != null) 'created_at': createdAt,
      if (startDate != null) 'start_date': startDate,
      if (completionDate != null) 'completion_date': completionDate,
    });
  }

  ProjectsCompanion copyWith(
      {Value<int>? projectID,
      Value<String>? name,
      Value<String>? description,
      Value<String>? state,
      Value<DateTime>? createdAt,
      Value<DateTime?>? startDate,
      Value<DateTime?>? completionDate}) {
    return ProjectsCompanion(
      projectID: projectID ?? this.projectID,
      name: name ?? this.name,
      description: description ?? this.description,
      state: state ?? this.state,
      createdAt: createdAt ?? this.createdAt,
      startDate: startDate ?? this.startDate,
      completionDate: completionDate ?? this.completionDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (projectID.present) {
      map['project_i_d'] = Variable<int>(projectID.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (completionDate.present) {
      map['completion_date'] = Variable<DateTime>(completionDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('projectID: $projectID, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('state: $state, ')
          ..write('createdAt: $createdAt, ')
          ..write('startDate: $startDate, ')
          ..write('completionDate: $completionDate')
          ..write(')'))
        .toString();
  }
}

class $SegmentsTable extends Segments with TableInfo<$SegmentsTable, Segment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SegmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _segmentIDMeta =
      const VerificationMeta('segmentID');
  @override
  late final GeneratedColumn<int> segmentID = GeneratedColumn<int>(
      'segment_i_d', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
      'state', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _completionDateMeta =
      const VerificationMeta('completionDate');
  @override
  late final GeneratedColumn<DateTime> completionDate =
      GeneratedColumn<DateTime>('completion_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _projectIDMeta =
      const VerificationMeta('projectID');
  @override
  late final GeneratedColumn<int> projectID = GeneratedColumn<int>(
      'project_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES projects (project_i_d)'));
  @override
  List<GeneratedColumn> get $columns =>
      [segmentID, name, state, type, startDate, completionDate, projectID];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'segments';
  @override
  VerificationContext validateIntegrity(Insertable<Segment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('segment_i_d')) {
      context.handle(
          _segmentIDMeta,
          segmentID.isAcceptableOrUnknown(
              data['segment_i_d']!, _segmentIDMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('completion_date')) {
      context.handle(
          _completionDateMeta,
          completionDate.isAcceptableOrUnknown(
              data['completion_date']!, _completionDateMeta));
    }
    if (data.containsKey('project_i_d')) {
      context.handle(
          _projectIDMeta,
          projectID.isAcceptableOrUnknown(
              data['project_i_d']!, _projectIDMeta));
    } else if (isInserting) {
      context.missing(_projectIDMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {segmentID};
  @override
  Segment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Segment(
      segmentID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}segment_i_d'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      state: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date']),
      completionDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}completion_date']),
      projectID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}project_i_d'])!,
    );
  }

  @override
  $SegmentsTable createAlias(String alias) {
    return $SegmentsTable(attachedDatabase, alias);
  }
}

class Segment extends DataClass implements Insertable<Segment> {
  final int segmentID;
  final String name;
  final String state;
  final String type;
  final DateTime? startDate;
  final DateTime? completionDate;
  final int projectID;
  const Segment(
      {required this.segmentID,
      required this.name,
      required this.state,
      required this.type,
      this.startDate,
      this.completionDate,
      required this.projectID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['segment_i_d'] = Variable<int>(segmentID);
    map['name'] = Variable<String>(name);
    map['state'] = Variable<String>(state);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || completionDate != null) {
      map['completion_date'] = Variable<DateTime>(completionDate);
    }
    map['project_i_d'] = Variable<int>(projectID);
    return map;
  }

  SegmentsCompanion toCompanion(bool nullToAbsent) {
    return SegmentsCompanion(
      segmentID: Value(segmentID),
      name: Value(name),
      state: Value(state),
      type: Value(type),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      completionDate: completionDate == null && nullToAbsent
          ? const Value.absent()
          : Value(completionDate),
      projectID: Value(projectID),
    );
  }

  factory Segment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Segment(
      segmentID: serializer.fromJson<int>(json['segmentID']),
      name: serializer.fromJson<String>(json['name']),
      state: serializer.fromJson<String>(json['state']),
      type: serializer.fromJson<String>(json['type']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      completionDate: serializer.fromJson<DateTime?>(json['completionDate']),
      projectID: serializer.fromJson<int>(json['projectID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'segmentID': serializer.toJson<int>(segmentID),
      'name': serializer.toJson<String>(name),
      'state': serializer.toJson<String>(state),
      'type': serializer.toJson<String>(type),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'completionDate': serializer.toJson<DateTime?>(completionDate),
      'projectID': serializer.toJson<int>(projectID),
    };
  }

  Segment copyWith(
          {int? segmentID,
          String? name,
          String? state,
          String? type,
          Value<DateTime?> startDate = const Value.absent(),
          Value<DateTime?> completionDate = const Value.absent(),
          int? projectID}) =>
      Segment(
        segmentID: segmentID ?? this.segmentID,
        name: name ?? this.name,
        state: state ?? this.state,
        type: type ?? this.type,
        startDate: startDate.present ? startDate.value : this.startDate,
        completionDate:
            completionDate.present ? completionDate.value : this.completionDate,
        projectID: projectID ?? this.projectID,
      );
  Segment copyWithCompanion(SegmentsCompanion data) {
    return Segment(
      segmentID: data.segmentID.present ? data.segmentID.value : this.segmentID,
      name: data.name.present ? data.name.value : this.name,
      state: data.state.present ? data.state.value : this.state,
      type: data.type.present ? data.type.value : this.type,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      completionDate: data.completionDate.present
          ? data.completionDate.value
          : this.completionDate,
      projectID: data.projectID.present ? data.projectID.value : this.projectID,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Segment(')
          ..write('segmentID: $segmentID, ')
          ..write('name: $name, ')
          ..write('state: $state, ')
          ..write('type: $type, ')
          ..write('startDate: $startDate, ')
          ..write('completionDate: $completionDate, ')
          ..write('projectID: $projectID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      segmentID, name, state, type, startDate, completionDate, projectID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Segment &&
          other.segmentID == this.segmentID &&
          other.name == this.name &&
          other.state == this.state &&
          other.type == this.type &&
          other.startDate == this.startDate &&
          other.completionDate == this.completionDate &&
          other.projectID == this.projectID);
}

class SegmentsCompanion extends UpdateCompanion<Segment> {
  final Value<int> segmentID;
  final Value<String> name;
  final Value<String> state;
  final Value<String> type;
  final Value<DateTime?> startDate;
  final Value<DateTime?> completionDate;
  final Value<int> projectID;
  const SegmentsCompanion({
    this.segmentID = const Value.absent(),
    this.name = const Value.absent(),
    this.state = const Value.absent(),
    this.type = const Value.absent(),
    this.startDate = const Value.absent(),
    this.completionDate = const Value.absent(),
    this.projectID = const Value.absent(),
  });
  SegmentsCompanion.insert({
    this.segmentID = const Value.absent(),
    required String name,
    required String state,
    required String type,
    this.startDate = const Value.absent(),
    this.completionDate = const Value.absent(),
    required int projectID,
  })  : name = Value(name),
        state = Value(state),
        type = Value(type),
        projectID = Value(projectID);
  static Insertable<Segment> custom({
    Expression<int>? segmentID,
    Expression<String>? name,
    Expression<String>? state,
    Expression<String>? type,
    Expression<DateTime>? startDate,
    Expression<DateTime>? completionDate,
    Expression<int>? projectID,
  }) {
    return RawValuesInsertable({
      if (segmentID != null) 'segment_i_d': segmentID,
      if (name != null) 'name': name,
      if (state != null) 'state': state,
      if (type != null) 'type': type,
      if (startDate != null) 'start_date': startDate,
      if (completionDate != null) 'completion_date': completionDate,
      if (projectID != null) 'project_i_d': projectID,
    });
  }

  SegmentsCompanion copyWith(
      {Value<int>? segmentID,
      Value<String>? name,
      Value<String>? state,
      Value<String>? type,
      Value<DateTime?>? startDate,
      Value<DateTime?>? completionDate,
      Value<int>? projectID}) {
    return SegmentsCompanion(
      segmentID: segmentID ?? this.segmentID,
      name: name ?? this.name,
      state: state ?? this.state,
      type: type ?? this.type,
      startDate: startDate ?? this.startDate,
      completionDate: completionDate ?? this.completionDate,
      projectID: projectID ?? this.projectID,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (segmentID.present) {
      map['segment_i_d'] = Variable<int>(segmentID.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (completionDate.present) {
      map['completion_date'] = Variable<DateTime>(completionDate.value);
    }
    if (projectID.present) {
      map['project_i_d'] = Variable<int>(projectID.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SegmentsCompanion(')
          ..write('segmentID: $segmentID, ')
          ..write('name: $name, ')
          ..write('state: $state, ')
          ..write('type: $type, ')
          ..write('startDate: $startDate, ')
          ..write('completionDate: $completionDate, ')
          ..write('projectID: $projectID')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _taskIDMeta = const VerificationMeta('taskID');
  @override
  late final GeneratedColumn<int> taskID = GeneratedColumn<int>(
      'task_i_d', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
      'state', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
      'priority', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _completionDateMeta =
      const VerificationMeta('completionDate');
  @override
  late final GeneratedColumn<DateTime> completionDate =
      GeneratedColumn<DateTime>('completion_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _segmentIDMeta =
      const VerificationMeta('segmentID');
  @override
  late final GeneratedColumn<int> segmentID = GeneratedColumn<int>(
      'segment_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES segments (segment_i_d)'));
  @override
  List<GeneratedColumn> get $columns => [
        taskID,
        name,
        description,
        state,
        priority,
        createdAt,
        startDate,
        completionDate,
        segmentID
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('task_i_d')) {
      context.handle(_taskIDMeta,
          taskID.isAcceptableOrUnknown(data['task_i_d']!, _taskIDMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('completion_date')) {
      context.handle(
          _completionDateMeta,
          completionDate.isAcceptableOrUnknown(
              data['completion_date']!, _completionDateMeta));
    }
    if (data.containsKey('segment_i_d')) {
      context.handle(
          _segmentIDMeta,
          segmentID.isAcceptableOrUnknown(
              data['segment_i_d']!, _segmentIDMeta));
    } else if (isInserting) {
      context.missing(_segmentIDMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {taskID};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      taskID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}task_i_d'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      state: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date']),
      completionDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}completion_date']),
      segmentID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}segment_i_d'])!,
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final int taskID;
  final String name;
  final String description;
  final String state;
  final int priority;
  final DateTime createdAt;
  final DateTime? startDate;
  final DateTime? completionDate;
  final int segmentID;
  const Task(
      {required this.taskID,
      required this.name,
      required this.description,
      required this.state,
      required this.priority,
      required this.createdAt,
      this.startDate,
      this.completionDate,
      required this.segmentID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['task_i_d'] = Variable<int>(taskID);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['state'] = Variable<String>(state);
    map['priority'] = Variable<int>(priority);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || completionDate != null) {
      map['completion_date'] = Variable<DateTime>(completionDate);
    }
    map['segment_i_d'] = Variable<int>(segmentID);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      taskID: Value(taskID),
      name: Value(name),
      description: Value(description),
      state: Value(state),
      priority: Value(priority),
      createdAt: Value(createdAt),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      completionDate: completionDate == null && nullToAbsent
          ? const Value.absent()
          : Value(completionDate),
      segmentID: Value(segmentID),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      taskID: serializer.fromJson<int>(json['taskID']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      state: serializer.fromJson<String>(json['state']),
      priority: serializer.fromJson<int>(json['priority']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      completionDate: serializer.fromJson<DateTime?>(json['completionDate']),
      segmentID: serializer.fromJson<int>(json['segmentID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'taskID': serializer.toJson<int>(taskID),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'state': serializer.toJson<String>(state),
      'priority': serializer.toJson<int>(priority),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'completionDate': serializer.toJson<DateTime?>(completionDate),
      'segmentID': serializer.toJson<int>(segmentID),
    };
  }

  Task copyWith(
          {int? taskID,
          String? name,
          String? description,
          String? state,
          int? priority,
          DateTime? createdAt,
          Value<DateTime?> startDate = const Value.absent(),
          Value<DateTime?> completionDate = const Value.absent(),
          int? segmentID}) =>
      Task(
        taskID: taskID ?? this.taskID,
        name: name ?? this.name,
        description: description ?? this.description,
        state: state ?? this.state,
        priority: priority ?? this.priority,
        createdAt: createdAt ?? this.createdAt,
        startDate: startDate.present ? startDate.value : this.startDate,
        completionDate:
            completionDate.present ? completionDate.value : this.completionDate,
        segmentID: segmentID ?? this.segmentID,
      );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      taskID: data.taskID.present ? data.taskID.value : this.taskID,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      state: data.state.present ? data.state.value : this.state,
      priority: data.priority.present ? data.priority.value : this.priority,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      completionDate: data.completionDate.present
          ? data.completionDate.value
          : this.completionDate,
      segmentID: data.segmentID.present ? data.segmentID.value : this.segmentID,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('taskID: $taskID, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('state: $state, ')
          ..write('priority: $priority, ')
          ..write('createdAt: $createdAt, ')
          ..write('startDate: $startDate, ')
          ..write('completionDate: $completionDate, ')
          ..write('segmentID: $segmentID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(taskID, name, description, state, priority,
      createdAt, startDate, completionDate, segmentID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.taskID == this.taskID &&
          other.name == this.name &&
          other.description == this.description &&
          other.state == this.state &&
          other.priority == this.priority &&
          other.createdAt == this.createdAt &&
          other.startDate == this.startDate &&
          other.completionDate == this.completionDate &&
          other.segmentID == this.segmentID);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<int> taskID;
  final Value<String> name;
  final Value<String> description;
  final Value<String> state;
  final Value<int> priority;
  final Value<DateTime> createdAt;
  final Value<DateTime?> startDate;
  final Value<DateTime?> completionDate;
  final Value<int> segmentID;
  const TasksCompanion({
    this.taskID = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.state = const Value.absent(),
    this.priority = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.startDate = const Value.absent(),
    this.completionDate = const Value.absent(),
    this.segmentID = const Value.absent(),
  });
  TasksCompanion.insert({
    this.taskID = const Value.absent(),
    required String name,
    required String description,
    required String state,
    required int priority,
    required DateTime createdAt,
    this.startDate = const Value.absent(),
    this.completionDate = const Value.absent(),
    required int segmentID,
  })  : name = Value(name),
        description = Value(description),
        state = Value(state),
        priority = Value(priority),
        createdAt = Value(createdAt),
        segmentID = Value(segmentID);
  static Insertable<Task> custom({
    Expression<int>? taskID,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? state,
    Expression<int>? priority,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? startDate,
    Expression<DateTime>? completionDate,
    Expression<int>? segmentID,
  }) {
    return RawValuesInsertable({
      if (taskID != null) 'task_i_d': taskID,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (state != null) 'state': state,
      if (priority != null) 'priority': priority,
      if (createdAt != null) 'created_at': createdAt,
      if (startDate != null) 'start_date': startDate,
      if (completionDate != null) 'completion_date': completionDate,
      if (segmentID != null) 'segment_i_d': segmentID,
    });
  }

  TasksCompanion copyWith(
      {Value<int>? taskID,
      Value<String>? name,
      Value<String>? description,
      Value<String>? state,
      Value<int>? priority,
      Value<DateTime>? createdAt,
      Value<DateTime?>? startDate,
      Value<DateTime?>? completionDate,
      Value<int>? segmentID}) {
    return TasksCompanion(
      taskID: taskID ?? this.taskID,
      name: name ?? this.name,
      description: description ?? this.description,
      state: state ?? this.state,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      startDate: startDate ?? this.startDate,
      completionDate: completionDate ?? this.completionDate,
      segmentID: segmentID ?? this.segmentID,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (taskID.present) {
      map['task_i_d'] = Variable<int>(taskID.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (completionDate.present) {
      map['completion_date'] = Variable<DateTime>(completionDate.value);
    }
    if (segmentID.present) {
      map['segment_i_d'] = Variable<int>(segmentID.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('taskID: $taskID, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('state: $state, ')
          ..write('priority: $priority, ')
          ..write('createdAt: $createdAt, ')
          ..write('startDate: $startDate, ')
          ..write('completionDate: $completionDate, ')
          ..write('segmentID: $segmentID')
          ..write(')'))
        .toString();
  }
}

class $TodosTable extends Todos with TableInfo<$TodosTable, Todo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _todoIDMeta = const VerificationMeta('todoID');
  @override
  late final GeneratedColumn<int> todoID = GeneratedColumn<int>(
      'todo_i_d', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _taskIDMeta = const VerificationMeta('taskID');
  @override
  late final GeneratedColumn<int> taskID = GeneratedColumn<int>(
      'task_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES tasks (task_i_d)'));
  @override
  List<GeneratedColumn> get $columns =>
      [todoID, name, startedAt, completedAt, taskID];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todos';
  @override
  VerificationContext validateIntegrity(Insertable<Todo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('todo_i_d')) {
      context.handle(_todoIDMeta,
          todoID.isAcceptableOrUnknown(data['todo_i_d']!, _todoIDMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('task_i_d')) {
      context.handle(_taskIDMeta,
          taskID.isAcceptableOrUnknown(data['task_i_d']!, _taskIDMeta));
    } else if (isInserting) {
      context.missing(_taskIDMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {todoID};
  @override
  Todo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Todo(
      todoID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}todo_i_d'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at']),
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
      taskID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}task_i_d'])!,
    );
  }

  @override
  $TodosTable createAlias(String alias) {
    return $TodosTable(attachedDatabase, alias);
  }
}

class Todo extends DataClass implements Insertable<Todo> {
  final int todoID;
  final String name;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final int taskID;
  const Todo(
      {required this.todoID,
      required this.name,
      this.startedAt,
      this.completedAt,
      required this.taskID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['todo_i_d'] = Variable<int>(todoID);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['task_i_d'] = Variable<int>(taskID);
    return map;
  }

  TodosCompanion toCompanion(bool nullToAbsent) {
    return TodosCompanion(
      todoID: Value(todoID),
      name: Value(name),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      taskID: Value(taskID),
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Todo(
      todoID: serializer.fromJson<int>(json['todoID']),
      name: serializer.fromJson<String>(json['name']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      taskID: serializer.fromJson<int>(json['taskID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'todoID': serializer.toJson<int>(todoID),
      'name': serializer.toJson<String>(name),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'taskID': serializer.toJson<int>(taskID),
    };
  }

  Todo copyWith(
          {int? todoID,
          String? name,
          Value<DateTime?> startedAt = const Value.absent(),
          Value<DateTime?> completedAt = const Value.absent(),
          int? taskID}) =>
      Todo(
        todoID: todoID ?? this.todoID,
        name: name ?? this.name,
        startedAt: startedAt.present ? startedAt.value : this.startedAt,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        taskID: taskID ?? this.taskID,
      );
  Todo copyWithCompanion(TodosCompanion data) {
    return Todo(
      todoID: data.todoID.present ? data.todoID.value : this.todoID,
      name: data.name.present ? data.name.value : this.name,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      taskID: data.taskID.present ? data.taskID.value : this.taskID,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Todo(')
          ..write('todoID: $todoID, ')
          ..write('name: $name, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('taskID: $taskID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(todoID, name, startedAt, completedAt, taskID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Todo &&
          other.todoID == this.todoID &&
          other.name == this.name &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.taskID == this.taskID);
}

class TodosCompanion extends UpdateCompanion<Todo> {
  final Value<int> todoID;
  final Value<String> name;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> completedAt;
  final Value<int> taskID;
  const TodosCompanion({
    this.todoID = const Value.absent(),
    this.name = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.taskID = const Value.absent(),
  });
  TodosCompanion.insert({
    this.todoID = const Value.absent(),
    required String name,
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    required int taskID,
  })  : name = Value(name),
        taskID = Value(taskID);
  static Insertable<Todo> custom({
    Expression<int>? todoID,
    Expression<String>? name,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<int>? taskID,
  }) {
    return RawValuesInsertable({
      if (todoID != null) 'todo_i_d': todoID,
      if (name != null) 'name': name,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (taskID != null) 'task_i_d': taskID,
    });
  }

  TodosCompanion copyWith(
      {Value<int>? todoID,
      Value<String>? name,
      Value<DateTime?>? startedAt,
      Value<DateTime?>? completedAt,
      Value<int>? taskID}) {
    return TodosCompanion(
      todoID: todoID ?? this.todoID,
      name: name ?? this.name,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      taskID: taskID ?? this.taskID,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (todoID.present) {
      map['todo_i_d'] = Variable<int>(todoID.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (taskID.present) {
      map['task_i_d'] = Variable<int>(taskID.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodosCompanion(')
          ..write('todoID: $todoID, ')
          ..write('name: $name, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('taskID: $taskID')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final $SegmentsTable segments = $SegmentsTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $TodosTable todos = $TodosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [projects, segments, tasks, todos];
}

typedef $$ProjectsTableCreateCompanionBuilder = ProjectsCompanion Function({
  Value<int> projectID,
  required String name,
  required String description,
  required String state,
  required DateTime createdAt,
  Value<DateTime?> startDate,
  Value<DateTime?> completionDate,
});
typedef $$ProjectsTableUpdateCompanionBuilder = ProjectsCompanion Function({
  Value<int> projectID,
  Value<String> name,
  Value<String> description,
  Value<String> state,
  Value<DateTime> createdAt,
  Value<DateTime?> startDate,
  Value<DateTime?> completionDate,
});

final class $$ProjectsTableReferences
    extends BaseReferences<_$AppDatabase, $ProjectsTable, Project> {
  $$ProjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SegmentsTable, List<Segment>> _segmentsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.segments,
          aliasName: $_aliasNameGenerator(
              db.projects.projectID, db.segments.projectID));

  $$SegmentsTableProcessedTableManager get segmentsRefs {
    final manager = $$SegmentsTableTableManager($_db, $_db.segments)
        .filter((f) => f.projectID.projectID($_item.projectID));

    final cache = $_typedResult.readTableOrNull(_segmentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ProjectsTableFilterComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get projectID => $composableBuilder(
      column: $table.projectID, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completionDate => $composableBuilder(
      column: $table.completionDate,
      builder: (column) => ColumnFilters(column));

  Expression<bool> segmentsRefs(
      Expression<bool> Function($$SegmentsTableFilterComposer f) f) {
    final $$SegmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.projectID,
        referencedTable: $db.segments,
        getReferencedColumn: (t) => t.projectID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SegmentsTableFilterComposer(
              $db: $db,
              $table: $db.segments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get projectID => $composableBuilder(
      column: $table.projectID, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completionDate => $composableBuilder(
      column: $table.completionDate,
      builder: (column) => ColumnOrderings(column));
}

class $$ProjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get projectID =>
      $composableBuilder(column: $table.projectID, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get completionDate => $composableBuilder(
      column: $table.completionDate, builder: (column) => column);

  Expression<T> segmentsRefs<T extends Object>(
      Expression<T> Function($$SegmentsTableAnnotationComposer a) f) {
    final $$SegmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.projectID,
        referencedTable: $db.segments,
        getReferencedColumn: (t) => t.projectID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SegmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.segments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProjectsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProjectsTable,
    Project,
    $$ProjectsTableFilterComposer,
    $$ProjectsTableOrderingComposer,
    $$ProjectsTableAnnotationComposer,
    $$ProjectsTableCreateCompanionBuilder,
    $$ProjectsTableUpdateCompanionBuilder,
    (Project, $$ProjectsTableReferences),
    Project,
    PrefetchHooks Function({bool segmentsRefs})> {
  $$ProjectsTableTableManager(_$AppDatabase db, $ProjectsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> projectID = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> state = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> completionDate = const Value.absent(),
          }) =>
              ProjectsCompanion(
            projectID: projectID,
            name: name,
            description: description,
            state: state,
            createdAt: createdAt,
            startDate: startDate,
            completionDate: completionDate,
          ),
          createCompanionCallback: ({
            Value<int> projectID = const Value.absent(),
            required String name,
            required String description,
            required String state,
            required DateTime createdAt,
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> completionDate = const Value.absent(),
          }) =>
              ProjectsCompanion.insert(
            projectID: projectID,
            name: name,
            description: description,
            state: state,
            createdAt: createdAt,
            startDate: startDate,
            completionDate: completionDate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ProjectsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({segmentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (segmentsRefs) db.segments],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (segmentsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$ProjectsTableReferences._segmentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProjectsTableReferences(db, table, p0)
                                .segmentsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.projectID == item.projectID),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ProjectsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProjectsTable,
    Project,
    $$ProjectsTableFilterComposer,
    $$ProjectsTableOrderingComposer,
    $$ProjectsTableAnnotationComposer,
    $$ProjectsTableCreateCompanionBuilder,
    $$ProjectsTableUpdateCompanionBuilder,
    (Project, $$ProjectsTableReferences),
    Project,
    PrefetchHooks Function({bool segmentsRefs})>;
typedef $$SegmentsTableCreateCompanionBuilder = SegmentsCompanion Function({
  Value<int> segmentID,
  required String name,
  required String state,
  required String type,
  Value<DateTime?> startDate,
  Value<DateTime?> completionDate,
  required int projectID,
});
typedef $$SegmentsTableUpdateCompanionBuilder = SegmentsCompanion Function({
  Value<int> segmentID,
  Value<String> name,
  Value<String> state,
  Value<String> type,
  Value<DateTime?> startDate,
  Value<DateTime?> completionDate,
  Value<int> projectID,
});

final class $$SegmentsTableReferences
    extends BaseReferences<_$AppDatabase, $SegmentsTable, Segment> {
  $$SegmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIDTable(_$AppDatabase db) =>
      db.projects.createAlias(
          $_aliasNameGenerator(db.segments.projectID, db.projects.projectID));

  $$ProjectsTableProcessedTableManager get projectID {
    final manager = $$ProjectsTableTableManager($_db, $_db.projects)
        .filter((f) => f.projectID($_item.projectID!));
    final item = $_typedResult.readTableOrNull(_projectIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TasksTable, List<Task>> _tasksRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.tasks,
          aliasName:
              $_aliasNameGenerator(db.segments.segmentID, db.tasks.segmentID));

  $$TasksTableProcessedTableManager get tasksRefs {
    final manager = $$TasksTableTableManager($_db, $_db.tasks)
        .filter((f) => f.segmentID.segmentID($_item.segmentID));

    final cache = $_typedResult.readTableOrNull(_tasksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SegmentsTableFilterComposer
    extends Composer<_$AppDatabase, $SegmentsTable> {
  $$SegmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get segmentID => $composableBuilder(
      column: $table.segmentID, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completionDate => $composableBuilder(
      column: $table.completionDate,
      builder: (column) => ColumnFilters(column));

  $$ProjectsTableFilterComposer get projectID {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.projectID,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.projectID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableFilterComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> tasksRefs(
      Expression<bool> Function($$TasksTableFilterComposer f) f) {
    final $$TasksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.segmentID,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.segmentID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableFilterComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SegmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $SegmentsTable> {
  $$SegmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get segmentID => $composableBuilder(
      column: $table.segmentID, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completionDate => $composableBuilder(
      column: $table.completionDate,
      builder: (column) => ColumnOrderings(column));

  $$ProjectsTableOrderingComposer get projectID {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.projectID,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.projectID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableOrderingComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SegmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SegmentsTable> {
  $$SegmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get segmentID =>
      $composableBuilder(column: $table.segmentID, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get completionDate => $composableBuilder(
      column: $table.completionDate, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectID {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.projectID,
        referencedTable: $db.projects,
        getReferencedColumn: (t) => t.projectID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProjectsTableAnnotationComposer(
              $db: $db,
              $table: $db.projects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> tasksRefs<T extends Object>(
      Expression<T> Function($$TasksTableAnnotationComposer a) f) {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.segmentID,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.segmentID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableAnnotationComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SegmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SegmentsTable,
    Segment,
    $$SegmentsTableFilterComposer,
    $$SegmentsTableOrderingComposer,
    $$SegmentsTableAnnotationComposer,
    $$SegmentsTableCreateCompanionBuilder,
    $$SegmentsTableUpdateCompanionBuilder,
    (Segment, $$SegmentsTableReferences),
    Segment,
    PrefetchHooks Function({bool projectID, bool tasksRefs})> {
  $$SegmentsTableTableManager(_$AppDatabase db, $SegmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SegmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SegmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SegmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> segmentID = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> state = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> completionDate = const Value.absent(),
            Value<int> projectID = const Value.absent(),
          }) =>
              SegmentsCompanion(
            segmentID: segmentID,
            name: name,
            state: state,
            type: type,
            startDate: startDate,
            completionDate: completionDate,
            projectID: projectID,
          ),
          createCompanionCallback: ({
            Value<int> segmentID = const Value.absent(),
            required String name,
            required String state,
            required String type,
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> completionDate = const Value.absent(),
            required int projectID,
          }) =>
              SegmentsCompanion.insert(
            segmentID: segmentID,
            name: name,
            state: state,
            type: type,
            startDate: startDate,
            completionDate: completionDate,
            projectID: projectID,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$SegmentsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({projectID = false, tasksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (tasksRefs) db.tasks],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (projectID) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.projectID,
                    referencedTable:
                        $$SegmentsTableReferences._projectIDTable(db),
                    referencedColumn:
                        $$SegmentsTableReferences._projectIDTable(db).projectID,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tasksRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$SegmentsTableReferences._tasksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SegmentsTableReferences(db, table, p0).tasksRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.segmentID == item.segmentID),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SegmentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SegmentsTable,
    Segment,
    $$SegmentsTableFilterComposer,
    $$SegmentsTableOrderingComposer,
    $$SegmentsTableAnnotationComposer,
    $$SegmentsTableCreateCompanionBuilder,
    $$SegmentsTableUpdateCompanionBuilder,
    (Segment, $$SegmentsTableReferences),
    Segment,
    PrefetchHooks Function({bool projectID, bool tasksRefs})>;
typedef $$TasksTableCreateCompanionBuilder = TasksCompanion Function({
  Value<int> taskID,
  required String name,
  required String description,
  required String state,
  required int priority,
  required DateTime createdAt,
  Value<DateTime?> startDate,
  Value<DateTime?> completionDate,
  required int segmentID,
});
typedef $$TasksTableUpdateCompanionBuilder = TasksCompanion Function({
  Value<int> taskID,
  Value<String> name,
  Value<String> description,
  Value<String> state,
  Value<int> priority,
  Value<DateTime> createdAt,
  Value<DateTime?> startDate,
  Value<DateTime?> completionDate,
  Value<int> segmentID,
});

final class $$TasksTableReferences
    extends BaseReferences<_$AppDatabase, $TasksTable, Task> {
  $$TasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SegmentsTable _segmentIDTable(_$AppDatabase db) =>
      db.segments.createAlias(
          $_aliasNameGenerator(db.tasks.segmentID, db.segments.segmentID));

  $$SegmentsTableProcessedTableManager get segmentID {
    final manager = $$SegmentsTableTableManager($_db, $_db.segments)
        .filter((f) => f.segmentID($_item.segmentID!));
    final item = $_typedResult.readTableOrNull(_segmentIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TodosTable, List<Todo>> _todosRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.todos,
          aliasName: $_aliasNameGenerator(db.tasks.taskID, db.todos.taskID));

  $$TodosTableProcessedTableManager get todosRefs {
    final manager = $$TodosTableTableManager($_db, $_db.todos)
        .filter((f) => f.taskID.taskID($_item.taskID));

    final cache = $_typedResult.readTableOrNull(_todosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get taskID => $composableBuilder(
      column: $table.taskID, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completionDate => $composableBuilder(
      column: $table.completionDate,
      builder: (column) => ColumnFilters(column));

  $$SegmentsTableFilterComposer get segmentID {
    final $$SegmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.segmentID,
        referencedTable: $db.segments,
        getReferencedColumn: (t) => t.segmentID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SegmentsTableFilterComposer(
              $db: $db,
              $table: $db.segments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> todosRefs(
      Expression<bool> Function($$TodosTableFilterComposer f) f) {
    final $$TodosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskID,
        referencedTable: $db.todos,
        getReferencedColumn: (t) => t.taskID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TodosTableFilterComposer(
              $db: $db,
              $table: $db.todos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get taskID => $composableBuilder(
      column: $table.taskID, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get state => $composableBuilder(
      column: $table.state, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completionDate => $composableBuilder(
      column: $table.completionDate,
      builder: (column) => ColumnOrderings(column));

  $$SegmentsTableOrderingComposer get segmentID {
    final $$SegmentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.segmentID,
        referencedTable: $db.segments,
        getReferencedColumn: (t) => t.segmentID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SegmentsTableOrderingComposer(
              $db: $db,
              $table: $db.segments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get taskID =>
      $composableBuilder(column: $table.taskID, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get completionDate => $composableBuilder(
      column: $table.completionDate, builder: (column) => column);

  $$SegmentsTableAnnotationComposer get segmentID {
    final $$SegmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.segmentID,
        referencedTable: $db.segments,
        getReferencedColumn: (t) => t.segmentID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SegmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.segments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> todosRefs<T extends Object>(
      Expression<T> Function($$TodosTableAnnotationComposer a) f) {
    final $$TodosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskID,
        referencedTable: $db.todos,
        getReferencedColumn: (t) => t.taskID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TodosTableAnnotationComposer(
              $db: $db,
              $table: $db.todos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TasksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TasksTable,
    Task,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableAnnotationComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder,
    (Task, $$TasksTableReferences),
    Task,
    PrefetchHooks Function({bool segmentID, bool todosRefs})> {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> taskID = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> state = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> completionDate = const Value.absent(),
            Value<int> segmentID = const Value.absent(),
          }) =>
              TasksCompanion(
            taskID: taskID,
            name: name,
            description: description,
            state: state,
            priority: priority,
            createdAt: createdAt,
            startDate: startDate,
            completionDate: completionDate,
            segmentID: segmentID,
          ),
          createCompanionCallback: ({
            Value<int> taskID = const Value.absent(),
            required String name,
            required String description,
            required String state,
            required int priority,
            required DateTime createdAt,
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> completionDate = const Value.absent(),
            required int segmentID,
          }) =>
              TasksCompanion.insert(
            taskID: taskID,
            name: name,
            description: description,
            state: state,
            priority: priority,
            createdAt: createdAt,
            startDate: startDate,
            completionDate: completionDate,
            segmentID: segmentID,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TasksTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({segmentID = false, todosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (todosRefs) db.todos],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (segmentID) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.segmentID,
                    referencedTable: $$TasksTableReferences._segmentIDTable(db),
                    referencedColumn:
                        $$TasksTableReferences._segmentIDTable(db).segmentID,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (todosRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$TasksTableReferences._todosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TasksTableReferences(db, table, p0).todosRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.taskID == item.taskID),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TasksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TasksTable,
    Task,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableAnnotationComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder,
    (Task, $$TasksTableReferences),
    Task,
    PrefetchHooks Function({bool segmentID, bool todosRefs})>;
typedef $$TodosTableCreateCompanionBuilder = TodosCompanion Function({
  Value<int> todoID,
  required String name,
  Value<DateTime?> startedAt,
  Value<DateTime?> completedAt,
  required int taskID,
});
typedef $$TodosTableUpdateCompanionBuilder = TodosCompanion Function({
  Value<int> todoID,
  Value<String> name,
  Value<DateTime?> startedAt,
  Value<DateTime?> completedAt,
  Value<int> taskID,
});

final class $$TodosTableReferences
    extends BaseReferences<_$AppDatabase, $TodosTable, Todo> {
  $$TodosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TasksTable _taskIDTable(_$AppDatabase db) => db.tasks
      .createAlias($_aliasNameGenerator(db.todos.taskID, db.tasks.taskID));

  $$TasksTableProcessedTableManager get taskID {
    final manager = $$TasksTableTableManager($_db, $_db.tasks)
        .filter((f) => f.taskID($_item.taskID!));
    final item = $_typedResult.readTableOrNull(_taskIDTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TodosTableFilterComposer extends Composer<_$AppDatabase, $TodosTable> {
  $$TodosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get todoID => $composableBuilder(
      column: $table.todoID, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  $$TasksTableFilterComposer get taskID {
    final $$TasksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskID,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.taskID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableFilterComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TodosTableOrderingComposer
    extends Composer<_$AppDatabase, $TodosTable> {
  $$TodosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get todoID => $composableBuilder(
      column: $table.todoID, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  $$TasksTableOrderingComposer get taskID {
    final $$TasksTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskID,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.taskID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableOrderingComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TodosTableAnnotationComposer
    extends Composer<_$AppDatabase, $TodosTable> {
  $$TodosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get todoID =>
      $composableBuilder(column: $table.todoID, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  $$TasksTableAnnotationComposer get taskID {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskID,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.taskID,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableAnnotationComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TodosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TodosTable,
    Todo,
    $$TodosTableFilterComposer,
    $$TodosTableOrderingComposer,
    $$TodosTableAnnotationComposer,
    $$TodosTableCreateCompanionBuilder,
    $$TodosTableUpdateCompanionBuilder,
    (Todo, $$TodosTableReferences),
    Todo,
    PrefetchHooks Function({bool taskID})> {
  $$TodosTableTableManager(_$AppDatabase db, $TodosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TodosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TodosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TodosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> todoID = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime?> startedAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<int> taskID = const Value.absent(),
          }) =>
              TodosCompanion(
            todoID: todoID,
            name: name,
            startedAt: startedAt,
            completedAt: completedAt,
            taskID: taskID,
          ),
          createCompanionCallback: ({
            Value<int> todoID = const Value.absent(),
            required String name,
            Value<DateTime?> startedAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            required int taskID,
          }) =>
              TodosCompanion.insert(
            todoID: todoID,
            name: name,
            startedAt: startedAt,
            completedAt: completedAt,
            taskID: taskID,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TodosTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({taskID = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (taskID) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.taskID,
                    referencedTable: $$TodosTableReferences._taskIDTable(db),
                    referencedColumn:
                        $$TodosTableReferences._taskIDTable(db).taskID,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TodosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TodosTable,
    Todo,
    $$TodosTableFilterComposer,
    $$TodosTableOrderingComposer,
    $$TodosTableAnnotationComposer,
    $$TodosTableCreateCompanionBuilder,
    $$TodosTableUpdateCompanionBuilder,
    (Todo, $$TodosTableReferences),
    Todo,
    PrefetchHooks Function({bool taskID})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db, _db.projects);
  $$SegmentsTableTableManager get segments =>
      $$SegmentsTableTableManager(_db, _db.segments);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$TodosTableTableManager get todos =>
      $$TodosTableTableManager(_db, _db.todos);
}
