import 'package:flutter/material.dart';
import 'router.dart';

void main() {
  // Only needed if you do async work before runApp(); harmless to keep.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyFreezerApp());
}

class MyFreezerApp extends StatelessWidget {
  const MyFreezerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'MyFreezer',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF2DB7F7), // ice blue
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF2DB7F7),
        brightness: Brightness.dark,
      ),
      routerConfig: appRouter,
    );
  }
}
