import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sleev_frontend/screens/register_screen.dart';

import '../screens/global_progress_screen.dart';
import '../screens/login_screen.dart';
import '../screens/splash_screen.dart';

Map<String, Widget Function(BuildContext)> myRoutes = {
  '/splash': (context) => const SplashScreen(),
  '/home': (context) => FutureBuilder<String?>(
        future: _checkAuthToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final authToken = snapshot.data;
            if (authToken == null) {
              return const LoginScreen();
            } else {
              return const GlobalProgressScreen();
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
  '/auth': (context) => const LoginScreen(),
  '/auth/register': (context) => const RegisterScreen(),
};

Future<String?> _checkAuthToken() async {
  const storage = FlutterSecureStorage();
  return await storage.read(key: 'authToken');
}
