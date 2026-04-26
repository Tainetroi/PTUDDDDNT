import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'views/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Đã điền thông số từ file JSON của bạn vào đây
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDYuMlkJEegmSMf5-KqEFan-EvCbk9b62E",
      appId: "1:123137374331:android:aec44c62ab0897674a8ade",
      messagingSenderId: "123137374331",
      projectId: "lab4flutter-b816b",
      storageBucket: "lab4flutter-b816b.firebasestorage.app",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
    );
  }
}
