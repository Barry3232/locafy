import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:locafy/features/screens/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseAppCheck.instance.activate(
  //   androidProvider: AndroidProvider.debug,
  // );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Locafy',
      home: SplashScreen(),
    ),
  );
}
