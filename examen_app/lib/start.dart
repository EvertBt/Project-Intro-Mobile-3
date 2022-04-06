import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  const Start({required this.body, Key? key}) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const IconButton(
            icon: Icon(Icons.menu),
            onPressed: null,
          ),
          title: const Center(child: Text('Examen App')),
          backgroundColor: const Color.fromARGB(255, 174, 15, 11),
        ),
        body: body,
        bottomNavigationBar: Container(
          height: 100.0,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 174, 15, 11),
              boxShadow: [BoxShadow(blurRadius: 5.0)]),
        ));
  }
}
