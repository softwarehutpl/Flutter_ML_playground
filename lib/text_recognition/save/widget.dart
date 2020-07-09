import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readnod/navigation.dart';
import 'package:readnod/text_recognition/camera/widget.dart';
import 'package:readnod/text_recognition/save/bloc.dart';
import 'package:readnod/text_recognition/save/events.dart';
import 'package:readnod/text_recognition/save/states.dart';
import 'package:readnod/translations.dart';

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
  SaveBloc _bloc;
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    _bloc = SaveBloc(repository: RepositoryProvider.of(context));
    final textToShare = (ModalRoute.of(context).settings.arguments as SaveArguments).textToShare;

    return BlocProvider(
      create: (BuildContext context) => _bloc,
      child: BlocListener<SaveBloc, SaveState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is CloseScreenState) {
            popScreen(context);
          } else if (_textController.text != state.text) {
            _textController.text = state.text;
          }
        },
        child: BlocBuilder<SaveBloc, SaveState>(
          bloc: _bloc..add(TextChangedEvent(newText: textToShare)),
          builder: (BuildContext context, SaveState state) {
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
                    labelText: Translations.of(context).saveEditLabel,
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
              child: Text(Translations.of(context).save.toUpperCase()),
              onPressed: () async {
                _bloc.add(SaveTextEvent());
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
