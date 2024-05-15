import 'package:flutter/material.dart';
import 'emergency_calls_screen.dart';
import 'Splashscreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emergency Calls',
      debugShowCheckedModeBanner: false,
      theme: _appTheme(),
      // home: const MyHomePage(),
      // home: child,
      home: const SplashScreenPage()
    );
  }

  ThemeData _appTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: Colors.red,
          fontSize: 20,
        ),
        centerTitle: true,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _homeBody(),
    );
  }

  Widget _homeBody() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.lightBlue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const EmergencyCallsScreen(),
    );
  }
}