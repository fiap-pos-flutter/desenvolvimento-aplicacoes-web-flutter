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
  final List<String> imageUrls = [
    'https://www.combatarena.net/cdn/shop/articles/bjj.jpg?v=1695911535',
    'https://cdn.evolve-mma.com/wp-content/uploads/2022/11/BJJ-beginners-guide.jpg',
    'https://cdn.evolve-mma.com/wp-content/uploads/2015/05/why-bjj-is-the-perfect-martial-art.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Gallery'),
      ),
      body: ListView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Image.network(imageUrls[index]);
        },
      ),
    );
  }
}