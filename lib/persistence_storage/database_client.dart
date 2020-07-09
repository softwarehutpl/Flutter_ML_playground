import 'package:readnod/persistence_storage/database.dart';

class DatabaseClient {

  final _db = Database();

  Future<void> insertTextRecognition(String text) {
    return _db.textRecognitionDao.upsertRecognition(
      TextRecognitionsCompanion.insert(recognizedText: text)
    );
  }
}