import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:core';

import 'package:xeroti/home/main.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();

  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        title: "Xeroti",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
            secondary: Color.fromRGBO(230, 49, 255, 1.0),
            brightness: Brightness.dark,
          ),
          primaryColor: Colors.black,
          accentColor: Color.fromRGBO(230, 49, 255, 1.0),
          cardColor: Colors.white,
          cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(29),
            ),
          ),
          unselectedWidgetColor: Colors.black,
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.black),
            headline2: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.black),
            headline3: TextStyle(fontSize: 56.0, fontWeight: FontWeight.bold, color: Colors.black),
            headline4: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold, color: Colors.black),
            headline5: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.black),
            headline6: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
            button: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
            bodyText1: TextStyle(fontSize: 20.0, color: Colors.black),
            bodyText2: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: Color.fromRGBO(230, 49, 255, 1.0),
            selectionHandleColor: Color.fromRGBO(230, 49, 255, 1.0),
            cursorColor: Color.fromRGBO(230, 49, 255, 1.0),
          ),
          backgroundColor: Colors.black54,
          dividerTheme: DividerThemeData(
            thickness: 1,
          ),
          scaffoldBackgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
          snackBarTheme: SnackBarThemeData(
            backgroundColor: Colors.grey,
            actionTextColor: Colors.white,
          ),
          splashColor: Colors.black,
          dividerColor: Colors.grey,
          appBarTheme: const AppBarTheme(
            color: Colors.white,
          ),
          bottomAppBarColor: Colors.white,
          canvasColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        color: Color.fromRGBO(230, 49, 255, 1.0),
        home: Home(_cameras)
    );
  }
}
