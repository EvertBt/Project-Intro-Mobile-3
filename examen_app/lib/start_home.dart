import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 150.0,
          margin: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
          child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 227, 5, 20),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.all(8.0),
                elevation: 5,
              ),
              child: const Text(
                'Student',
                style: TextStyle(fontSize: 50.0),
              )),
        ),
        Container(
          width: double.infinity,
          height: 150.0,
          margin: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
          child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 227, 5, 20),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.all(8.0),
                elevation: 5,
              ),
              child: const Text(
                'Admin',
                style: TextStyle(fontSize: 50.0),
              )),
        ),
      ],
    ));
  }
}
