import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readnod/navigation.dart';
import 'package:readnod/text_recognition/camera/widget.dart';
import 'package:readnod/text_recognition/history/bloc.dart';
import 'package:readnod/text_recognition/history/events.dart';
import 'package:readnod/text_recognition/history/states.dart';
import 'package:readnod/translations.dart';
import 'package:share/share.dart';

class RecognizedTextHistory extends StatefulWidget {
  static final route = "/";

  @override
  _RecognizedTextHistoryState createState() => _RecognizedTextHistoryState();
}

class _RecognizedTextHistoryState extends State<RecognizedTextHistory> {

  static final int _startCameraButtonCompensation = 1;
  static final int _startCameraButtonIndex = 0;
  static final int _emptyListLabelCompensation = 1;
  static final int _emptyListLabelIndex = 1;
  static final int _loadingCompensation = 1;
  static final int _loadingIndex = 1;

  HistoryBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = HistoryBloc(repository: RepositoryProvider.of(context));

    return BlocProvider(
      create: (BuildContext context) => _bloc,
      child: BlocBuilder<HistoryBloc, HistoryState>(
        bloc: _bloc..add(LoadHistoryEvent()),
        builder: (BuildContext context, HistoryState state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(Translations.of(context).title),
            ),
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, HistoryState state) {
    return ListView.builder(
      itemCount: _calculateListLength(state),
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        if (_shouldBuildStartCameraButton(index)) {
          return _buildStartCameraButton(context);
        }
        if (_shouldBuildLoadingIndicator(state, index)) {
          return _buildLoadingIndicator(context);
        }
        if (_shouldBuildNoElements(state, index)) {
          return _buildNoElements(context);
        }
        return _buildHistoryElement(context, state, index);
      },
    );
  }

  int _calculateListLength(HistoryState state) {
    bool isHistoryEmpty = state.recognizedTextHistory.isEmpty;
    int length = state.recognizedTextHistory.length + _startCameraButtonCompensation;
    if (isHistoryEmpty && state is LoadedHistoryState) {
      length += _emptyListLabelCompensation;
    }
    if (isHistoryEmpty && state is InitialHistoryState) {
      length += _loadingCompensation;
    }
    return length;
  }

  bool _shouldBuildStartCameraButton(int index) {
    return index == _startCameraButtonIndex;
  }

  Widget _buildStartCameraButton(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            child: Text(Translations.of(context).cameraPreview.toUpperCase()),
            onPressed: ()  {
              pushScreenNamed(context, CameraPreviewWidget.route);
            },
          ),
        ),
      ],
    );
  }

  bool _shouldBuildLoadingIndicator(HistoryState state, int index) {
    return state is InitialHistoryState && index == _loadingIndex;
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox.fromSize(
              size: Size.square(64.0),
              child: CircularProgressIndicator()
          ),
        ],
      ),
    );
  }

  bool _shouldBuildNoElements(HistoryState state, int index) {
    return state is LoadedHistoryState
        && state.recognizedTextHistory.isEmpty
        && index == _emptyListLabelIndex;
  }

  Widget _buildNoElements(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          Translations.of(context).noRecognitions,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.blueGrey
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryElement(BuildContext context, HistoryState state, int index) {
    final recognizedText = state.recognizedTextHistory[index - _startCameraButtonCompensation];
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            _buildRecognizedText(recognizedText),
            _buildShareAction(recognizedText),
          ],
        ),
      ),
    );
  }

  Widget _buildRecognizedText(String recognizedText) {
    return Expanded(child: Text(recognizedText));
  }

  Widget _buildShareAction(String text) {
    return IconButton(
        icon: Icon(
          Icons.share,
          color: Colors.black,
          size: 24,
        ),
        onPressed: () async {
          await Share.share(text);
        });
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
