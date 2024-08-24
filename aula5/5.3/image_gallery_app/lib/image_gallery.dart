import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_gallery_app/extensions/context_extension.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'main.dart';

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
      final instance = Firebase.app(firebaseAppName);
      final storageRef = FirebaseStorage.instanceFor(app: instance).ref();

      final imagesRef = storageRef.child('images/$_imageName');
      final uploadTask = imagesRef.putBlob(
        _imageBlob!,
        SettableMetadata(),
      );

      setState(() {
        loading = true;
      });

      await uploadTask.whenComplete(() => null);

      //final snapshot = await uploadTask.whenComplete(() => null);
      //await snapshot.ref.getDownloadURL();

      setState(() {
        loading = false;
      });

      print('Imagem enviada');
    } catch (e) {
      print('Falha ao fazer upload da imagem: $e');
    }
  }

  void _changeLanguage(Locale locale) {
    setState(() {
      MyApp.setLocale(context, locale);
    });
  }

  void _changeTheme(ThemeData theme) {
    MyApp.setTheme(context, theme);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              if (Theme.of(context).brightness == Brightness.dark) {
                _changeTheme(lightTheme);
              } else {
                _changeTheme(darkTheme);
              }
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'English') {
                _changeLanguage(const Locale('en'));
              } else if (value == 'Português') {
                _changeLanguage(const Locale('pt'));
              }
            },
            itemBuilder: (BuildContext context) {
              return {'English', 'Português'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
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
                : Text(AppLocalizations.of(context)!.no_image_selected),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text(AppLocalizations.of(context)!.select_image),
            ),
            const SizedBox(height: 10),
            if (_imageBlob != null)
              ElevatedButton(
                onPressed: () async {
                  if (_imageBlob != null) {
                    await _uploadImage();
                  }
                },
                child: const Text('Fazer Upload'),
              ),
            const SizedBox(height: 10),
            if (loading != null && loading == true)
              const CircularProgressIndicator(),
            if (loading != null && loading == false)
              Text(AppLocalizations.of(context)!.image_uploaded),
          ],
        ),
      ),
    );
  }
}
