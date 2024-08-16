import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDYyaV4ih52UM3z9aqJmT-pZqGtYY7HjCI',
      appId: '1:107757801504:web:3ebc12624b49663b066c45',
      messagingSenderId: '107757801504',
      projectId: 'fiap-post-flutter',
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Gallery App'),
        ),
        body: Center(
          child: Text('Firebase Initialized Successfully!'),
        ),
      ),
    );
  }
}
