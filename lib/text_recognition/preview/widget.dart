import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:readnod/navigation.dart';
import 'package:readnod/text_recognition/preview/bloc.dart';
import 'package:readnod/text_recognition/preview/events.dart';
import 'package:readnod/text_recognition/preview/states.dart';
import 'package:flutter/services.dart';
import 'package:readnod/translations.dart';

class CameraPreviewWidget extends StatefulWidget {
  static final route = "/text/recognition/preview";

  @override
  _CameraPreviewWidgetState createState() => _CameraPreviewWidgetState();
}

class _CameraPreviewWidgetState extends State<CameraPreviewWidget> {
  final PreviewBloc _bloc = PreviewBloc();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _bloc,
      child: BlocBuilder<PreviewBloc, PreviewState>(
        bloc: _bloc..add(InitializePreviewEvent()),
        builder: (BuildContext context, PreviewState state) {
          Widget content = _buildLoadingIndicator(context);
          if (state is ReadyPreviewState) {
            content = _buildCameraPreview(context, state);
          }
          if (state is PermissionsNotGrantedPreviewState) {
            content = _buildPermissionsNotGranted(context);
          }
          if (state is UnknownErrorPreviewState) {
            content = _buildUnknownError(context);
          }

          return Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                content,
                Positioned(top: 0.0, right: 0.0, child: _buildCloseButton(context)),
                Positioned(
                  bottom: 0.0,
                  child: _buildSwitchCameraButton(context, state),
                )
              ]..addAll(_buildRecognizedTexts(context, state)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCameraPreview(BuildContext context, ReadyPreviewState state) {
    final controller = state.controller;
    final size = MediaQuery.of(context).size;
    double deviceRatio = size.width / size.height;

    return Transform.scale(
      scale: controller.value.aspectRatio / deviceRatio,
      child: Center(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: CameraPreview(controller),
        ),
      ),
    );
  }

  Widget _buildPermissionsNotGranted(BuildContext context) {
    return _buildError(context, Translations.of(context).cameraPermissionsNotGranted);
  }

  Widget _buildUnknownError(BuildContext context) {
    return _buildError(context, Translations.of(context).cameraUnknownError);
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              message,
              textAlign: TextAlign.center,
            ),
          ),
          RaisedButton(
              child: Text(Translations.of(context).retry.toUpperCase()),
              onPressed: () {
                _bloc.add(InitializePreviewEvent());
              }),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        child: CircularProgressIndicator(),
        size: Size.square(64),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: Colors.white54,
        child: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              popScreen(context);
            }),
      ),
    );
  }

  Widget _buildSwitchCameraButton(BuildContext context, PreviewState state) {
    if (state is ReadyPreviewState) {
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox.fromSize(
          size: Size.fromRadius(32),
          child: CircleAvatar(
            backgroundColor: Colors.white54,
            child: IconButton(
                icon: Icon(
                  Icons.switch_camera,
                  color: Colors.black,
                  size: 32,
                ),
                onPressed: () {
                  _bloc.add(SwitchCameraPreviewEvent());
                }),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  List<Widget> _buildRecognizedTexts(BuildContext context, PreviewState state) {
    final List<Widget> texts = [];
    if (state is ReadyPreviewState && state.texts != null) {
      final size = MediaQuery.of(context).size;
      final deviceRatio = size.width / size.height;
      final imageRatio = state.imageAspectRatio;
      final ratio = ((state.controller.value.aspectRatio) / (deviceRatio / imageRatio));
      final textsWidgets = state.texts.map((e) {
        print(e.text);
        /* TODO take into account device orientation */
        final topTranslatedToPreview = e.boundingBox.top * ratio;
        final leftTranslatedToPreview = e.boundingBox.left * ratio;
        return Positioned(
            top: topTranslatedToPreview,
            left: leftTranslatedToPreview,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                e.text,
                style: TextStyle(
                    backgroundColor: Colors.white70,
                    color: Colors.black
                ),
              ),
            )
        );
      });
      texts.addAll(textsWidgets);
    }
    return texts;
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _bloc.close();
    super.dispose();
  }
}
