import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  String statusMessage = "Press the button to start detection";

  void startDetection() async {
    try {
      final response = await http.get(Uri.parse('http://http://192.168.198.46:5000/detect'));

      if (response.statusCode == 200) {
        setState(() {
          statusMessage = "Video recording and object detection started";
        });
      } else {
        setState(() {
          statusMessage = "Failed to start detection";
        });
      }
    } catch (e) {
      print("Error starting detection: $e");
      setState(() {
        statusMessage = "Failed to start detection";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Detect"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/camera.png'),
            const SizedBox(height: 20),
            Text(
              statusMessage,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: startDetection,
              child: const Icon(Icons.camera_alt, size: 30),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

