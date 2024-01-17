import 'package:flutter/material.dart';

class ProgressAreaDetailsScreen extends StatefulWidget {
  final String area;

  const ProgressAreaDetailsScreen({required this.area, super.key});

  @override
  State<ProgressAreaDetailsScreen> createState() =>
      _ProgressAreaDetailsScreenState();
}

class _ProgressAreaDetailsScreenState extends State<ProgressAreaDetailsScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(
          widget.area,
          style: const TextStyle(
            fontSize: 28,
          ),
        ),
//      centerTitle: true,
      ),
      body: SingleChildScrollView(child: Container()));
}
