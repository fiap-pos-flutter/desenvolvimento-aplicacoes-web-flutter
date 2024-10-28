import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'image_gallery.dart';

const String firebaseAppName = 'web';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  //accentColor: Colors.blueAccent,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.grey[900],
  //accentColor: Colors.blueGrey,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blueGrey,
    textTheme: ButtonTextTheme.primary,
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var config = const FirebaseOptions(
    apiKey: "AIzaSyDYyaV4ih52UM3z9aqJmT-pZqGtYY7HjCI",
    authDomain: "fiap-post-flutter.firebaseapp.com",
    projectId: "fiap-post-flutter",
    storageBucket: "fiap-post-flutter.appspot.com",
    messagingSenderId: "107757801504",
    appId: "1:107757801504:web:3ebc12624b49663b066c45",
  );

  await Firebase.initializeApp(
    name: firebaseAppName,
    options: config,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setTheme(BuildContext context, ThemeData theme) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeTheme(theme);
  }

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale = const Locale('pt');
  ThemeData _themeData = lightTheme;

  void changeTheme(ThemeData theme) {
    setState(() {
      _themeData = theme;
    });
  }

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
      theme: _themeData,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
