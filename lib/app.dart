import 'package:flutter/material.dart';

import 'screens/home_page.dart';
import 'theme/app_theme.dart';

class RoshanApp extends StatelessWidget {
  const RoshanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Roshan',
      theme: AppTheme.zabonLight(),
      home: const HomePage(),
    );
  }
}
