import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
    return MaterialApp(
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
