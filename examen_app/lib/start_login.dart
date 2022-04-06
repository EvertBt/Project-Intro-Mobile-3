import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: 500.0,
            height: 150.0,
            margin: const EdgeInsets.symmetric(horizontal: 100.0),
            child: TextField(
              cursorColor: const Color.fromARGB(255, 227, 5, 20),
              decoration: InputDecoration(
                labelText: 'Wachtwoord',
                //errorText aanpassen voor fout wachtwoord
                labelStyle: const TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color.fromARGB(255, 227, 5, 20)),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black)),
              ),
            )),
        Container(
          width: 500.0,
          height: 100.0,
          margin: const EdgeInsets.symmetric(horizontal: 100.0),
          child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 227, 5, 20),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  padding: const EdgeInsets.all(8.0),
                  elevation: 5),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 50.0),
              )),
        ),
      ],
    ));
  }
}
