import 'package:examen_app/firebase/authentication.dart';

import 'package:examen_app/views/admin_start.dart';
import 'package:examen_app/config/constants.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String password = "";
  String? errortext;

  void _login() async {
    errortext = null;

    bool correctPassword = await Authenticator.authenticate(password);

    if (password == "") {
      errortext = "Dit veld mag niet leeg zijn";
    } else if (!correctPassword) {
      errortext = "Fout wachtwoord";
    } else if (correctPassword) {
      Navigator.pushNamed(context, adminStartRoute);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Examen App')),
          backgroundColor: primaryColor,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 500.0,
                height: 150.0,
                margin: const EdgeInsets.symmetric(horizontal: 100.0),
                child: TextField(
                  onChanged: (value) => password = value,
                  obscureText: true,
                  cursorColor: buttonColor,
                  decoration: InputDecoration(
                    labelText: 'Wachtwoord',
                    errorText: errortext,
                    labelStyle: const TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: buttonColor),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black)),
                  ),
                )),
            Container(
              width: 250.0,
              height: 90.0,
              margin: const EdgeInsets.symmetric(horizontal: 100.0),
              child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                      primary: buttonColor,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90)),
                      padding: const EdgeInsets.all(8.0),
                      elevation: 5),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 50.0),
                  )),
            ),
          ],
        )),
        bottomNavigationBar: Container(
            height: 56.0,
            padding: const EdgeInsets.only(left: 20.0),
            decoration: const BoxDecoration(color: primaryColor, boxShadow: [
              BoxShadow(
                blurRadius: 6.0,
                offset: Offset(0, 2.0),
              )
            ]),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 13.0),
                  child: const Image(
                    image: AssetImage('assets/logosmall.png'),
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ],
            )));
  }
}
