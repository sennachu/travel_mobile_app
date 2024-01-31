import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_app/screens/welcomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  // _welcomeScreen metodu eklendi
  Widget _welcomeScreen() {
    return WelcomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFEDF2F6),
      ),
      home: _welcomeScreen(), // _welcomeScreen metodu kullanıldı
    );
  }
}
