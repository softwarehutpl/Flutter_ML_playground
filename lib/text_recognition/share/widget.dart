import 'package:flutter/material.dart';

class ShareArguments {
  final String textToShare;

  ShareArguments({@required this.textToShare});
}

class ShareWidget extends StatefulWidget {
  static final route = "/text/recognition/share";

  @override
  _ShareWidgetState createState() => _ShareWidgetState();
}

class _ShareWidgetState extends State<ShareWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      /* TODO UI to edit provided text before saving & sharing it*/
    );
  }
}
