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

  void _changeTheme(ThemeData theme) {
    MyApp.setTheme(context, theme);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 1,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.photo_library_rounded),
            const SizedBox(
              width: 8,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Image: ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  const TextSpan(
                    text: 'Gallery',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                      color: Colors.blueAccent,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6, color: Colors.blueGrey[800]),
            onPressed: () {
              if (Theme.of(context).brightness == Brightness.dark) {
                _changeTheme(lightTheme);
              } else {
                _changeTheme(darkTheme);
              }
            },
          ),
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
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 8,
                shadowColor: Colors.black26,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.blueGrey.shade100,
                          ),
                        ),
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.memory(
                                  _image!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image,
                                    size: 80,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .no_image_selected,
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                    ),
                                  )
                                ],
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton.icon(
                        onPressed: _pickeImage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        icon: const Icon(
                          Icons.photo_library,
                          color: Colors.white,
                        ),
                        label: Text(AppLocalizations.of(context)!.select_image),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (_image != null)
                        ElevatedButton.icon(
                          onPressed: _uploadImage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                          icon: const Icon(
                            Icons.cloud_upload,
                            color: Colors.white,
                          ),
                          label:
                              Text(AppLocalizations.of(context)!.upload_image),
                        ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (loading != null && loading == true)
            Container(
              color: Colors.black.withOpacity(0.6),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(26),
                        child: Column(
                          children: [
                            const CircularProgressIndicator(
                              color: Colors.blueAccent,
                              strokeAlign: 5,
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            Text(
                              'Uploading...',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blueGrey[800],
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
