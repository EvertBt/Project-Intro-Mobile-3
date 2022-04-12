import 'package:examen_app/config/constants.dart';
import 'package:examen_app/views/home.dart';
import 'package:examen_app/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      onGenerateRoute: CustomRouter.generateRoute,
      initialRoute: homeRoute,
      debugShowCheckedModeBanner: false,
      title: 'Grade App',
      home: Home(),
    ),
  );
}
