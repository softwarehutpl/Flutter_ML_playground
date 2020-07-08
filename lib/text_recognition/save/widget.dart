import 'package:flutter/material.dart';

class SaveArguments {
  final String textToShare;

  SaveArguments({@required this.textToShare});
}

class SaveWidget extends StatefulWidget {
  static final route = "/text/recognition/save";

  @override
  _SaveWidgetState createState() => _SaveWidgetState();
}

class _SaveWidgetState extends State<SaveWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      /* TODO UI to edit provided text before saving & sharing it*/
    );
  }
}
