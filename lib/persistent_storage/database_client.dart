import 'package:readnod/persistent_storage/database.dart';

class DatabaseClient {

  final _db = Database();

  Future<void> insertTextRecognition(String text) {
    return _db.textRecognitionDao.upsertRecognition(
      TextRecognitionsCompanion.insert(recognizedText: text)
    );
  }

  Stream<List<TextRecognition>> watchRecognitions() {
    return _db.textRecognitionDao.watchRecognitions();
  }
}