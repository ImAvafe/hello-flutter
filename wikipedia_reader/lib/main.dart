import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'summary.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Wikipedia Reader')),
        body: Center(child: Text('aaaaaaaa')),
      ),
    );
  }
}
