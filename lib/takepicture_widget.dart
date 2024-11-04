import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePictureWidget extends StatefulWidget {
  const TakePictureWidget({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureWidgetScreenState createState() => TakePictureWidgetScreenState();
}

class TakePictureWidgetScreenState extends State<TakePictureWidget> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a Picture - 362358302012'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}