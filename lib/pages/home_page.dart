import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage ({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _obscureText = true;

  @override 
  Widget build(BuildContext context) {
    final Size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFF1494F6),
      body: Center(),
    );
  }
}