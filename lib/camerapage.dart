import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:logger/logger.dart';
import 'dart:io';

class CameraScreen extends StatefulWidget {
  final void Function(XFile? image)? onImageCaptured;

  const CameraScreen({Key? key, this.onImageCaptured}) : super(key: key);

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  late int _selectedCameraIndex;
  XFile? _capturedImage;
  var logger = Logger();

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    _selectedCameraIndex = 0;
    _cameraController = CameraController(
      _cameras[_selectedCameraIndex],
      ResolutionPreset.max,
    );

    await _cameraController.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _captureImage() async {
    try {
      final image = await _cameraController.takePicture();
      setState(() {
        _capturedImage = image;
      });
    } catch (e) {
      logger.e('Error taking picture: $e');
    }
  }

  void _recaptureImage() {
    setState(() {
      _capturedImage = null;
    });
  }

  void _runAnalysis() {
    if (_capturedImage != null) {
      // Call the callback function to send the captured image back to the parent
      widget.onImageCaptured?.call(_capturedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          if (_capturedImage == null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 100,
              child: AspectRatio(
                aspectRatio: _cameraController.value.aspectRatio,
                child: CameraPreview(_cameraController),
              ),
            )
          else
            Positioned.fill(
              child: Image.file(
                File(_capturedImage!.path),
                fit: BoxFit.cover,
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100.0,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _capturedImage == null
                    ? [
                        ElevatedButton(
                          onPressed: _captureImage,
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(20.0),
                          ),
                          child: const Icon(
                            Icons.camera,
                            size: 40.0,
                            color: Colors.black,
                          ),
                        ),
                      ]
                    : [
                        ElevatedButton(
                          onPressed: _recaptureImage,
                          child: const Text('Recapture'),
                        ),
                        const SizedBox(width: 20.0),
                        ElevatedButton(
                          onPressed: _runAnalysis,
                          child: const Text('Run Analysis'),
                        ),
                      ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
