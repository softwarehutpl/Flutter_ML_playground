import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            content = _buildCameraPreview(context, state.controller);
          }
          if (state is PermissionsNotGrantedPreviewState) {
            content = _buildPermissionsNotGranted(context);
          }
          if (state is UnknownErrorPreviewState) {
            content = _buildUnknownError(context);
          }

          return Scaffold(
            body: Stack(
              children: <Widget>[
                content,
                Positioned(
                    right: 0.0,
                    child: _buildCloseButton(context)
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: Colors.white54,
        child: IconButton(
            icon: Icon(Icons.close, color: Colors.black,),
            onPressed: () {
              popScreen(context);
            }
        ),
      ),
    );
  }

  Widget _buildCameraPreview(BuildContext context, CameraController controller) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
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
    return _buildError(
        context,
        Translations.of(context).cameraPermissionsNotGranted
    );
  }

  Widget _buildUnknownError(BuildContext context) {
    return _buildError(
        context,
        Translations.of(context).cameraUnknownError
    );
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

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    _bloc.close();
    super.dispose();
  }
}
