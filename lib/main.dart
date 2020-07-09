import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:readnod/persistent_storage/database_client.dart';
import 'package:readnod/text_recognition/repository.dart';
import 'package:readnod/text_recognition/save/widget.dart';
import 'package:readnod/text_recognition/share/widget.dart';
import 'package:readnod/translations.dart';
import 'package:readnod/navigation.dart';
import 'package:readnod/text_recognition/camera/widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _dbClient = DatabaseClient();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TextRecognitionRepository>(
          create: (context) => TextRecognitionRepository(databaseClient: _dbClient),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          const TranslationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale.fromSubtags(languageCode: 'en'),
          const Locale.fromSubtags(languageCode: 'pl'),
        ],
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: MyHomePage.route,
        routes: {
          MyHomePage.route: (_) => MyHomePage(),
          CameraPreviewWidget.route: (_) => CameraPreviewWidget(),
          ShareWidget.route: (_) => ShareWidget(),
          SaveWidget.route: (_) => SaveWidget(),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  static final route = "/";

  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Translations.of(context).title),
        ),
        body: Center(
          child: RaisedButton(
            child: Text(Translations.of(context).cameraPreview.toUpperCase()),
            onPressed: () {
              pushScreenNamed(context, CameraPreviewWidget.route);
            },
          ),
        ));
  }
}
