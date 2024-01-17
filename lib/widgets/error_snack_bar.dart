import 'package:flutter/material.dart';

class ErrorSnackBar extends StatelessWidget {
  final String message;

  const ErrorSnackBar({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.red, // Customize background color
      margin: EdgeInsets.zero,
      child: Row(
        children: [
          const Icon(
            Icons.error,
            color: Colors.white, // Customize icon color
          ),
          // const SizedBox(width: 8.0),
          Text(
            message,
            style: const TextStyle(
              color: Colors.white, // Customize text color
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
