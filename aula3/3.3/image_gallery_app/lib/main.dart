import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'image_gallery.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDYyaV4ih52UM3z9aqJmT-pZqGtYY7HjCI',
      authDomain: 'fiap-post-flutter.firebaseapp.com',
      appId: '1:107757801504:web:3ebc12624b49663b066c45',
      messagingSenderId: '107757801504',
      projectId: 'fiap-post-flutter',
      storageBucket: 'fiap-post-flutter.appspot.com',
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageGalleryApp(),
    );
  }
}
