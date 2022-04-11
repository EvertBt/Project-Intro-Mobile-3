import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';

import 'package:examen_app/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  final oldPwController = TextEditingController();
  final newPwController = TextEditingController();
  final confirmNewPwController = TextEditingController();

  String oldPassword = "";
  String newPassword = "";
  String? confirmNewPassword;

  String? oldPwErrortext;
  String? newPwErrortext;
  String? confirmNewPwErrortext;

  String successMessage = "";

  String _generatehash({String password = ""}) {
    var bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  //Update wachtwoord
  Future<void> _updatePassword(String newPassword) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseFirestore.instance
        .doc('authadmin/password')
        .update({'value': newPassword});
  }

  //check wachtwoord
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

  void _changePassword() async {
    oldPwErrortext = null;
    newPwErrortext = null;
    confirmNewPwErrortext = null;
    successMessage = "";

    bool correctPassword =
        await _authenticate(_generatehash(password: oldPassword));

    if (newPassword != confirmNewPassword) {
      confirmNewPwErrortext = "Oud en nieuw wachtwoord komen niet overeen";
    }
    if (newPassword == "") {
      newPwErrortext = "Dit veld mag niet leeg zijn";
    }
    if (confirmNewPassword == null || confirmNewPassword == "") {
      confirmNewPwErrortext = "Dit veld mag niet leeg zijn";
    }
    if (oldPassword == "") {
      oldPwErrortext = "Dit veld mag niet leeg zijn";
    } else if (!correctPassword) {
      oldPwErrortext = "Fout wachtwoord";
    } else if (correctPassword &&
        newPassword == confirmNewPassword &&
        newPassword != "" &&
        newPassword != "") {
      oldPwController.clear();
      newPwController.clear();
      confirmNewPwController.clear();

      await _updatePassword(_generatehash(password: newPassword));

      oldPassword = "";
      newPassword = "";
      confirmNewPassword = null;
      successMessage = "Wachtwoord succesvol gewijzigd";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50.0),
          ),
          InputField(
            labelText: "Oud wachtwoord",
            errorText: oldPwErrortext,
            onChanged: (value) => oldPassword = value,
            controller: oldPwController,
          ),
          InputField(
            labelText: "Nieuw wachtwoord",
            errorText: newPwErrortext,
            onChanged: (value) => newPassword = value,
            controller: newPwController,
          ),
          InputField(
            labelText: "Bevestig nieuw wachtwoord",
            errorText: confirmNewPwErrortext,
            onChanged: (value) => confirmNewPassword = value,
            controller: confirmNewPwController,
          ),
          Container(
            height: 20,
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              successMessage,
              style: const TextStyle(
                  fontSize: 16.0,
                  color: Color.fromARGB(255, 31, 121, 36),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 350.0,
            height: 70.0,
            margin: const EdgeInsets.symmetric(horizontal: 100.0),
            child: ElevatedButton(
                onPressed: _changePassword,
                style: ElevatedButton.styleFrom(
                    primary: CustomColor.button,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    padding: const EdgeInsets.all(8.0),
                    elevation: 5),
                child: const Text(
                  'Wijzig wachtwoord',
                  style: TextStyle(fontSize: 35.0),
                )),
          ),
        ],
      )),
    );
  }
}

class InputField extends StatelessWidget {
  const InputField(
      {required this.labelText,
      required this.errorText,
      required this.onChanged,
      this.controller,
      this.width = 500.0,
      this.height = 110.0,
      this.obscureText = true,
      Key? key})
      : super(key: key);

  final String labelText;
  final void Function(String)? onChanged;
  final String? errorText;
  final TextEditingController? controller;
  final double width;
  final double height;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          cursorColor: CustomColor.button,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(12, 24, 12, 20),
            labelText: labelText,
            errorText: errorText,
            labelStyle: const TextStyle(color: Colors.black),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: CustomColor.button),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black)),
          ),
        ));
  }
}
