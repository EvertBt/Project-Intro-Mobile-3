import 'package:examen_app/start_home.dart';
import 'package:examen_app/start.dart';
import 'package:examen_app/start_login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Flutter Tutorial',
      home: Start(
        body: Login(),
      ),
    ),
  );
}
