import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

class ImageGallery extends StatefulWidget {
  const ImageGallery({super.key});

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  Uint8List? _image;
  String? _imageName;
  bool? loading;

  Future<void> _pickeImage() async {
    final ImagePickerPlugin _picker = ImagePickerPlugin();
    final picketFile =
        await _picker.getImageFromSource(source: ImageSource.gallery);
    if (picketFile != null) {
      final bytes = await picketFile.readAsBytes();

      setState(() {
        _image = bytes;
      });
    }
  }

  Future<void> _uploadImage() async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child('images/$_imageName');
      final uploadTask = imageRef.putBlob(_image);

      setState(() {
        loading = true;
      });

      final snapshot = await uploadTask.whenComplete(() => null);
      await snapshot.ref.getDownloadURL();

      setState(() {
        loading = false;
      });

      print('Imagem enviada');
    } catch (e) {
      print('Falha ao fazer upload da imagem $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image gallery'),
      ),
      body: Center(
        child: Column(
          children: [
            _image != null ? Image.memory(_image!) : Text('No image selected.'),
            ElevatedButton(
              onPressed: _pickeImage,
              child: Text('pick image'),
            ),
            const SizedBox(
              height: 10,
            ),
            if (_image != null)
              ElevatedButton(
                onPressed: () async {
                  if (_image != null) {
                    await _uploadImage();
                  }
                },
                child: const Text('Upload'),
              ),
            const SizedBox(
              height: 10,
            ),
            if (loading != null && loading == true)
              const CircularProgressIndicator(),
            if (loading != null && loading == false)
              const Text('Imagem enviada com sucesso!'),
          ],
        ),
      ),
    );
  }
}
