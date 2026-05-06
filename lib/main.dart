import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:locafy/features/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Locafy',
      home: SplashScreen(),
    ),
  );
}
