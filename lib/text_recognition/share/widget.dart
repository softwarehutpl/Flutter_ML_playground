import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readnod/main.dart';
import 'package:readnod/navigation.dart';
import 'package:readnod/text_recognition/camera/widget.dart';
import 'package:readnod/text_recognition/share/bloc.dart';
import 'package:readnod/text_recognition/share/events.dart';
import 'package:readnod/text_recognition/share/states.dart';
import 'package:readnod/translations.dart';
import 'package:share/share.dart';

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
  final ShareBloc _bloc = ShareBloc();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFocus = FocusNode();
  bool _popToCamera = true;

  @override
  Widget build(BuildContext context) {
    final textToShare = (ModalRoute.of(context).settings.arguments as ShareArguments).textToShare;

    return BlocProvider(
      create: (BuildContext context) => _bloc,
      child: BlocListener<ShareBloc, ShareState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is DelegateShareState) {
            /* TODO */
          }
          if (_textController.text != state.text) {
            _textController.text = state.text;
          }
        },
        child: BlocBuilder<ShareBloc, ShareState>(
          bloc: _bloc..add(TextChangedEvent(newText: textToShare)),
          builder: (BuildContext context, ShareState state) {
            return WillPopScope(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(Translations.of(context).title),
                ),
                body: InkWell(
                  child: Column(
                    children: <Widget>[
                      _buildEditableText(context, state.text),
                      _buildShareButton(context, state.text),
                    ],
                  ),
                  onTap: () {
                    print("Should take away focus");
                    _textFocus.unfocus();
                  },
                ),
              ),
              onWillPop: () async {
                if (_popToCamera) {
                  pushReplacementNamed(context, CameraPreviewWidget.route);
                }
                return !_popToCamera;
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildEditableText(BuildContext context, String text) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                focusNode: _textFocus,
                controller: _textController,
                onChanged: (newText) {
                  if (newText != text) {
                    _bloc.add(TextChangedEvent(newText: newText));
                  }
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  border: InputBorder.none
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareButton(BuildContext context, String text) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text("Share"), /* TODO Localize */
              onPressed: () async {
                _popToCamera = false;
                await Share.share(text);
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _textFocus.dispose();
    _textController.dispose();
    _bloc.close();
    super.dispose();
  }
}
