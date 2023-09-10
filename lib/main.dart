import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'global_progress_screen.dart';
import 'register_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var storage = const FlutterSecureStorage();
  final token = await storage.read(key: 'authToken');

  runApp(
      MaterialApp(home: token != null ? const RegisterScreen() : const GlobalProgressScreen()));
}
