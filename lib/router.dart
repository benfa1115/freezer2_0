import 'package:go_router/go_router.dart';
import 'package:flutter/widgets.dart'; // for BuildContext
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/scan/qr_scanner_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) =>
          const LoginScreen(),
    ),
    GoRoute(
      path: '/scan',
      builder: (BuildContext context, GoRouterState state) =>
          const QrScannerScreen(),
    ),
  ],
);
