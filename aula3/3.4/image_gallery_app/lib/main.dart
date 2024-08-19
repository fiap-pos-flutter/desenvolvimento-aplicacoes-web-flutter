import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'image_gallery.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var config = const FirebaseOptions(
    apiKey: 'AIzaSyDYyaV4ih52UM3z9aqJmT-pZqGtYY7HjCI',
    authDomain: 'fiap-post-flutter.firebaseapp.com',
    appId: '1:107757801504:web:3ebc12624b49663b066c45',
    messagingSenderId: '107757801504',
    projectId: 'fiap-post-flutter',
    storageBucket: 'fiap-post-flutter.appspot.com',
  );

  await Firebase.initializeApp(
    options: config,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale = const Locale('pt');

  void changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageGalleryApp(),
      locale: _locale,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
