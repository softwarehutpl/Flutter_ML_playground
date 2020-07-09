// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class TextRecognition extends DataClass implements Insertable<TextRecognition> {
  final int id;
  final String recognizedText;
  TextRecognition({@required this.id, @required this.recognizedText});
  factory TextRecognition.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return TextRecognition(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      recognizedText: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}recognized_text']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || recognizedText != null) {
      map['recognized_text'] = Variable<String>(recognizedText);
    }
    return map;
  }

  TextRecognitionsCompanion toCompanion(bool nullToAbsent) {
    return TextRecognitionsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      recognizedText: recognizedText == null && nullToAbsent
          ? const Value.absent()
          : Value(recognizedText),
    );
  }

  factory TextRecognition.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TextRecognition(
      id: serializer.fromJson<int>(json['id']),
      recognizedText: serializer.fromJson<String>(json['recognizedText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recognizedText': serializer.toJson<String>(recognizedText),
    };
  }

  TextRecognition copyWith({int id, String recognizedText}) => TextRecognition(
        id: id ?? this.id,
        recognizedText: recognizedText ?? this.recognizedText,
      );
  @override
  String toString() {
    return (StringBuffer('TextRecognition(')
          ..write('id: $id, ')
          ..write('recognizedText: $recognizedText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, recognizedText.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TextRecognition &&
          other.id == this.id &&
          other.recognizedText == this.recognizedText);
}

class TextRecognitionsCompanion extends UpdateCompanion<TextRecognition> {
  final Value<int> id;
  final Value<String> recognizedText;
  const TextRecognitionsCompanion({
    this.id = const Value.absent(),
    this.recognizedText = const Value.absent(),
  });
  TextRecognitionsCompanion.insert({
    this.id = const Value.absent(),
    @required String recognizedText,
  }) : recognizedText = Value(recognizedText);
  static Insertable<TextRecognition> custom({
    Expression<int> id,
    Expression<String> recognizedText,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recognizedText != null) 'recognized_text': recognizedText,
    });
  }

  TextRecognitionsCompanion copyWith(
      {Value<int> id, Value<String> recognizedText}) {
    return TextRecognitionsCompanion(
      id: id ?? this.id,
      recognizedText: recognizedText ?? this.recognizedText,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recognizedText.present) {
      map['recognized_text'] = Variable<String>(recognizedText.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TextRecognitionsCompanion(')
          ..write('id: $id, ')
          ..write('recognizedText: $recognizedText')
          ..write(')'))
        .toString();
  }
}

class $TextRecognitionsTable extends TextRecognitions
    with TableInfo<$TextRecognitionsTable, TextRecognition> {
  final GeneratedDatabase _db;
  final String _alias;
  $TextRecognitionsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _recognizedTextMeta =
      const VerificationMeta('recognizedText');
  GeneratedTextColumn _recognizedText;
  @override
  GeneratedTextColumn get recognizedText =>
      _recognizedText ??= _constructRecognizedText();
  GeneratedTextColumn _constructRecognizedText() {
    return GeneratedTextColumn(
      'recognized_text',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, recognizedText];
  @override
  $TextRecognitionsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'text_recognitions';
  @override
  final String actualTableName = 'text_recognitions';
  @override
  VerificationContext validateIntegrity(Insertable<TextRecognition> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('recognized_text')) {
      context.handle(
          _recognizedTextMeta,
          recognizedText.isAcceptableOrUnknown(
              data['recognized_text'], _recognizedTextMeta));
    } else if (isInserting) {
      context.missing(_recognizedTextMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TextRecognition map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TextRecognition.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TextRecognitionsTable createAlias(String alias) {
    return $TextRecognitionsTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TextRecognitionsTable _textRecognitions;
  $TextRecognitionsTable get textRecognitions =>
      _textRecognitions ??= $TextRecognitionsTable(this);
  TextRecognitionDao _textRecognitionDao;
  TextRecognitionDao get textRecognitionDao =>
      _textRecognitionDao ??= TextRecognitionDao(this as Database);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [textRecognitions];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$TextRecognitionDaoMixin on DatabaseAccessor<Database> {
  $TextRecognitionsTable get textRecognitions =>
      attachedDatabase.textRecognitions;
}
