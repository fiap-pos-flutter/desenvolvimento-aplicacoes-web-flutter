import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Gallery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Image Gallery'),
    ),
    body: Row(
      children: [
        Flexible(
          child: Container(
            color: Colors.blue,
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Image.network('https://example.com/your-image.jpg'),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.red,
            child: Text('This is a flexible layout'),
          ),
        ),
      ],
    ),
  );
}
}