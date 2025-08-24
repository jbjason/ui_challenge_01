import 'package:flutter/material.dart';
import 'package:ui_challenge_01/pages/home.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Home()),
            );
          },
          child: Text("data"),
        ),
      ),
    );
  }
}
