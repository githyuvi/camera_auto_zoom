import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'main.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController? _cameraController;
  ImagePicker? _imagePicker;
  double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;

  @override
  void initState() {
    // TODO: implement initState

    _imagePicker = ImagePicker();

    _startLiveFeed();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera')),
      body: Stack(
        children: [
          CameraPreview(_cameraController!),
          Positioned(
            bottom: 100,
            left: 50,
            right: 50,
            child: Slider(
              value: zoomLevel,
              min: minZoomLevel,
              max: maxZoomLevel,
              onChanged: (newSliderValue) {
                setState(() {
                  zoomLevel = newSliderValue;
                  _cameraController!.setZoomLevel(zoomLevel);
                });
              },
              divisions: (maxZoomLevel - 1).toInt() < 1
                  ? null
                  : (maxZoomLevel - 1).toInt(),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _startLiveFeed() async {
    final cameraDescription = cameras[0];
    _cameraController = CameraController(cameraDescription, ResolutionPreset.high, enableAudio: false);
    await _cameraController!.initialize();
    setState(() {
      
    });
    _cameraController!.getMinZoomLevel().then((value) {
      zoomLevel = value;
      minZoomLevel = value;
    });
    _cameraController!.getMaxZoomLevel().then((value) {
      maxZoomLevel = value;
    });
    // await Future.delayed(Duration(seconds: 3)).then((value) => _cameraController!.pausePreview());
    // // await _cameraController?.takePicture();
    // await Future.delayed(Duration(seconds: 3)).then((value) => _cameraController!.resumePreview());
    
    

    setState(() {
      
    });
  }
}