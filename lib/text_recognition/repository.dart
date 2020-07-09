import 'package:flutter/material.dart';
import 'package:readnod/persistent_storage/database_client.dart';

class TextRecognitionRepository {

  final DatabaseClient databaseClient;

  TextRecognitionRepository({ @required this.databaseClient });

  Future<void> storeRecognizedText(String text) {
    return databaseClient.insertTextRecognition(text);
  }

  Stream<List<String>> watchRecognizedTexts() {
    return databaseClient.watchRecognitions()
        .map((recognitionsList) => recognitionsList.map((e) => e.recognizedText).toList());
  }
}