import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:crypto/crypto.dart';

import 'package:examen_app/admin_start.dart';
import 'package:examen_app/colors.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String password = "";
  String? errortext;

  String _generatehash({String password = ""}) {
    var bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  //Firebase communicatie
  Future<bool> _authenticate(String? password) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    var result = await FirebaseFirestore.instance
        .collection('authadmin')
        .where('value', isEqualTo: password)
        .get();

    return result.docs.isNotEmpty;
  }

  void _login() async {
    errortext = null;

    String passwordhash = _generatehash(password: password);
    bool correctPassword = await _authenticate(passwordhash);

    if (password == "") {
      errortext = "Dit veld mag niet leeg zijn";
    } else if (!correctPassword) {
      errortext = "Fout wachtwoord";
    } else if (correctPassword) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AdminStart()));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Examen App')),
          backgroundColor: CustomColor.primary,
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
                  cursorColor: CustomColor.button,
                  decoration: InputDecoration(
                    labelText: 'Wachtwoord',
                    errorText: errortext,
                    labelStyle: const TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: CustomColor.button),
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
                      primary: CustomColor.button,
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
            decoration: BoxDecoration(
                color: CustomColor.primary,
                boxShadow: const [
                  BoxShadow(blurRadius: 6.0, offset: Offset(0, 2.0))
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
