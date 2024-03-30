import 'package:flutter/material.dart';

class Connection extends StatefulWidget {
  const Connection({super.key});

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            "Connections"
        ),
      ),
    );
  }
}