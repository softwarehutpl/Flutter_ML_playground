import 'dart:io';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class TextRecognitions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get recognizedText => text()();
}

@UseDao(tables: [TextRecognitions])
class TextRecognitionDao extends DatabaseAccessor<Database> with _$TextRecognitionDaoMixin {
  final Database database;

  TextRecognitionDao(this.database) : super(database);

  Future<int> upsertRecognition(TextRecognitionsCompanion entry) {
    return into(textRecognitions).insert(entry, mode: InsertMode.insertOrReplace);
  }

  Stream<List<TextRecognition>> watchRecognitions() {
    return select(textRecognitions).watch();
  }

  Future<List<TextRecognition>> getRecognitions() {
    return select(textRecognitions).get();
  }
}

@UseMoor(tables: [TextRecognitions], daos: [TextRecognitionDao])
class Database extends _$Database {

  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}