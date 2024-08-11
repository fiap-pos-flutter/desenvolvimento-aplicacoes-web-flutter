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
    body: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return ListView(
            children: _buildImageList(),
          );
        } else {
          return GridView.count(
            crossAxisCount: 3,
            children: _buildImageList(),
          );
        }
      },
    ),
  );
}

List<Widget> _buildImageList() {
  return List.generate(10, (index) {
    return Image.network('https://example.com/image$index.jpg');
  });
}
}