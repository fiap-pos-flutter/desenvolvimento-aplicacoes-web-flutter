import 'dart:typed_data';

import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

class ImageGalleryApp extends StatefulWidget {
  @override
  _ImageGalleryAppState createState() => _ImageGalleryAppState();
}

class _ImageGalleryAppState extends State<ImageGalleryApp> {
  Uint8List? _image;

  Future<void> _pickImage() async {
    final ImagePickerPlugin _picker = ImagePickerPlugin();
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    final bytes = await pickedFile.readAsBytes();

    setState(() {
      _image = bytes;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Gallery'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image != null
                ? Image.memory(_image!)
                : Text('No image selected.'),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
          ],
        ),
      ),
    );
  }
}