import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_app/main.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final pickedFile =
        await _picker.getImageFromSource(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();

      _imageName = pickedFile.name;

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

  _changeLanguage(Locale locale) {
    setState(() {
      MyApp.setLocale(context, locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title),
        actions: [
          PopupMenuButton(onSelected: (String value) {
            if (value == "English") {
              _changeLanguage(Locale('en'));
            } else if (value == "Português") {
              _changeLanguage(Locale('pt'));
            }
          }, itemBuilder: (BuildContext context) {
            return {'English', 'Português'}.map((String choice) {
              return PopupMenuItem(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          }),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            _image != null
                ? Image.memory(_image!)
                : Text(AppLocalizations.of(context)!.no_image_selected),
            ElevatedButton(
              onPressed: _pickeImage,
              child: Text(AppLocalizations.of(context)!.select_image),
            ),
            const SizedBox(
              height: 10,
            ),
            if (_image != null)
              ElevatedButton(
                onPressed: _uploadImage,
                child: Text(AppLocalizations.of(context)!.upload_image),
              ),
            if (loading != null && loading == true) CircularProgressIndicator(),
            if (loading != null && loading == false)
              Text(AppLocalizations.of(context)!.image_uploaded)
          ],
        ),
      ),
    );
  }
}
