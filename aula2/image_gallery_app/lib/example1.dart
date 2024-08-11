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
  var screenSize = MediaQuery.of(context).size;

  return Scaffold(
    appBar: AppBar(
      title: Text('Image Gallery'),
    ),
    body: Center(
      child: screenSize.width < 600
          ? Column(
              children: [
                Text('Small Screen Layout'),
                Image.network('https://example.com/your-image.jpg'),
              ],
            )
          : Row(
              children: [
                Text('Large Screen Layout'),
                Image.network('https://example.com/your-image.jpg'),
              ],
            ),
    ),
  );
}
}