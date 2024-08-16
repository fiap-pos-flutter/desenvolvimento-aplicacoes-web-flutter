import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

class ImageGalleryApp extends StatefulWidget {
  @override
  _ImageGalleryAppState createState() => _ImageGalleryAppState();
}

class _ImageGalleryAppState extends State<ImageGalleryApp> {
  Uint8List? _imageBlob;
  String? _imageName;

  bool? loading;

  Future<void> _pickImage() async {
    final ImagePickerPlugin _picker = ImagePickerPlugin();
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    _imageName = pickedFile.name;

    final bytes = await pickedFile.readAsBytes();

    setState(() {
      _imageBlob = bytes;
    });
  }

  // Função para fazer upload da imagem selecionada para o Firebase Storage
  Future<void> _uploadImage() async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final imagesRef = storageRef.child('images/$_imageName');
      final uploadTask = imagesRef.putBlob(
        _imageBlob!,
        SettableMetadata(),
      );

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
      print('Falha ao fazer upload da imagem: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Gallery'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _imageBlob != null
                ? Image.memory(
                    _imageBlob!,
                    width: 200,
                    height: 200,
                  )
                : const Text('No image selected.'),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
            const SizedBox(height: 10,),
            if (_imageBlob != null)
              ElevatedButton(
                onPressed: () async {
                  if (_imageBlob != null) {
                    await _uploadImage();
                  }
                },
                child: const Text('Fazer Upload'),
              ),
              const SizedBox(height: 10,),
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
