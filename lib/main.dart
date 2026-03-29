import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'state/app_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) {
        final appState = AppState();
        appState.initializeDefaults();
        return appState;
      },
      child: const RoshanApp(),
    ),
  );
}

class MyApp extends RoshanApp {
  const MyApp({super.key});
}
