import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'image_gallery.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontSize: 32,
      color: Colors.grey,
    ),
  ),
);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
  ),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontSize: 32,
      color: Colors.pink,
    ),
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCwoPvRFTMnjoKFDr21uxyCNaCw3FhvlPE",
      appId: "1:514779891364:web:210eec466b0db31b844831",
      messagingSenderId: "514779891364",
      projectId: "image-gallery-web",
      storageBucket: "image-gallery-web.appspot.com",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setTheme(BuildContext context, ThemeData theme) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeTheme(theme);
  }

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale = const Locale('en');
  ThemeData _themeData = lightTheme;

  void changeTheme(ThemeData theme) {
    setState(() {
      _themeData = theme;
    });
  }

  void changeLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image gallery app',
      home: ImageGallery(),
      locale: _locale,
      theme: _themeData,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
