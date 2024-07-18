import 'package:flutter/material.dart';
import 'package:parkingslot/pages/signin.dart';
import 'package:parkingslot/pages/signup.dart';
import 'package:parkingslot/pages/verifikasi.dart';
import 'package:parkingslot/pages/camerascreen.dart';
import 'package:parkingslot/pages/analyticscreen.dart';
import 'package:parkingslot/pages/profilescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/signin',
      routes: {
        '/signin': (context) => Signin(),
        '/signup': (context) => Signup(),
        '/verifikasi': (context) => Verifikasi(),
        '/camerascreen': (context) => const CameraScreen(),
        '/analyticscreen': (context) => const AnalyticsScreen(),
        '/profilescreen': (context) => ProfileScreen(),
      },
    );
  }
}
