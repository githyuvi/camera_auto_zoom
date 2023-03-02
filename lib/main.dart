import 'package:camera_zoom/object_detection/object_detector_view.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

List<CameraDescription> cameras = [];
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  Permission.manageExternalStorage.request();
  cameras.forEach((element) => print('available camera' + element.name + 'lens direction : ${element.lensDirection} sensor orientation: ${element.sensorOrientation}'),);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'camera-auto-zoom',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(title: Text('Camera Zoom')),
      body: Center(child: ElevatedButton(
      onPressed: () async {
        await Permission.storage.request().isGranted.then((value) {
          print(value);
          if(value)
            Navigator.push(context, MaterialPageRoute(builder: (context) => ObjectDetectorView()));
        });
        // Navigator.push(context, MaterialPageRoute(builder: (context) => ObjectDetectorView()));
         },
      child: Text('Take Picture'),
      )),);
  }
}

