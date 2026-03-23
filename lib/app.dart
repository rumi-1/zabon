import 'package:flutter/material.dart';
import 'screens/home_page.dart';

class RoshanApp extends StatelessWidget {
  const RoshanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Roshan',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFBF6EE),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}