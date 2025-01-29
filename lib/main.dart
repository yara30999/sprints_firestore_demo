import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sprints_firestore_demo/firebase_options.dart';
import 'package:sprints_firestore_demo/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Demo',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
