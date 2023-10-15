import 'package:flutter/material.dart';
import 'package:sleev_frontend/services/api.dart';
import 'package:sleev_frontend/utils/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize the API class with the current context
    API.initialize(context);

    return MaterialApp(
      initialRoute: '/splash', // Set the initial route to the splash screen
      routes: myRoutes, // Use the routes from the external routes.dart file
    );
  }
}
