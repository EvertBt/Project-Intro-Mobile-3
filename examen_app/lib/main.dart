import 'package:flutter/material.dart';

void main() => runApp(const GHFlutterApp());

class GHFlutterApp extends StatelessWidget {
  const GHFlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Examen APP',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Examen APP'),
        ),
        body: const Center(
          child: Text('Examen APP'),
        ),
      ),
    );
  }
}
