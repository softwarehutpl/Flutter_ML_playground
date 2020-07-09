import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  ShareBloc _bloc;
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    _bloc = ShareBloc(repository: RepositoryProvider.of(context));
    final textToShare = (ModalRoute.of(context).settings.arguments as ShareArguments).textToShare;

    return BlocProvider(
      create: (BuildContext context) => _bloc,
      child: BlocListener<ShareBloc, ShareState>(
        bloc: _bloc,
        listener: (context, state) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildEditableText(context, state.text),
                      _buildShareButton(context, state.text),
                    ],
                  ),
                  onTap: () {
                    _textFocus.unfocus();
                  },
                ),
              ),
              onWillPop: () async {
                pushReplacementNamed(context, CameraPreviewWidget.route);
                return true;
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
                  labelText: Translations.of(context).shareEditLabel,
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
              child: Text(Translations.of(context).share.toUpperCase()),
              onPressed: () async {
                _bloc.add(SaveTextEvent());
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
    super.dispose();
  }
}
