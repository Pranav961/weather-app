import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}

String apiKey = "6aee6fe35a127e97cd66a2bb1420da21";
