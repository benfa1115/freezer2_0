import 'package:flutter/material.dart';
import 'router.dart';
import 'services/db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.instance.init();
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
