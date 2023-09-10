import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:sleev_frontend/api.dart';
import 'package:flutter/material.dart';

import 'error_snack_bar.dart';

class GlobalProgressScreen extends StatefulWidget {
  const GlobalProgressScreen({Key? key}) : super(key: key);

  @override
  State<GlobalProgressScreen> createState() => _GlobalProgressScreenState();
}

class _GlobalProgressScreenState extends State<GlobalProgressScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text(
          "MAIN",
          style: TextStyle(
            fontSize: 28,
          ),
        ),
//      centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            ProgressBarStatus(progressPhase: 1, area: 'F',),
            ProgressBarStatus(progressPhase: 2, area: 'A',),
            ProgressBarStatus(progressPhase: 3, area: 'C',),
            ProgressBarStatus(progressPhase: 2, area: 'E',),
            ProgressBarStatus(progressPhase: 2, area: 'I',),
            ProgressBarStatus(progressPhase: 1, area: 'S',),
          ],
        ),
      )));

  Future<void> loginUser(TextEditingController emailController,
      TextEditingController passwordController) async {
    Response result = await API.login(
        emailController.value.text, passwordController.value.text);

    if (result.statusCode == 200) {
      var body = json.decode(result.body);
      FlutterSecureStorage storage = const FlutterSecureStorage();
      await storage.write(key: 'authToken', value: body['auth_token']);
    } else {
      final scaffoldMessenger = ScaffoldMessenger.of(context);

      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: ErrorSnackBar(message: 'Custom SnackBar'),
          duration: const Duration(seconds: 3), // Adjust duration as needed
        ),
      );
    }
  }
}


class ProgressBarStatus extends StatelessWidget {
  final int progressPhase;
  final String area;

  ProgressBarStatus({super.key, 
    required this.progressPhase,
    required this.area,
  });

  @override
  Widget build(BuildContext context) {
    double progressStatus = progressPhase / 3.0;
    progressStatus = progressStatus.clamp(0.0, 1.0);

    Map<String, Color> colorChoosing = {
      "F": Colors.green,
      "A": Colors.red,
      "C": Colors.blue,
      "E": Colors.purple,
      "I": Colors.orange,
      "S": Colors.yellow,
    };

    Color? areaColor = colorChoosing[area];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50), // Removed horizontal padding
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(area)),
          Expanded(
            flex: 5,
            child: LinearProgressIndicator(
              value: progressStatus,
              minHeight: 10,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(areaColor ?? Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

