import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  final oldPwController = TextEditingController();
  final newPwController = TextEditingController();
  final confirmNewPwController = TextEditingController();

  String? oldPassword;
  String? newPassword;
  String? confirmNewPassword;

  String? oldPwErrortext;
  String? newPwErrortext;
  String? confirmNewPwErrortext;

  String successMessage = "";

  void _change() {
    setState(() {
      oldPwErrortext = null;
      newPwErrortext = null;
      confirmNewPwErrortext = null;
      successMessage = "";

      if (newPassword != confirmNewPassword) {
        confirmNewPwErrortext = "Oud en nieuw wachtwoord komen niet overeen";
      }
      if (newPassword == null || newPassword == "") {
        newPwErrortext = "Dit veld mag niet leeg zijn";
      }
      if (confirmNewPassword == null || confirmNewPassword == "") {
        confirmNewPwErrortext = "Dit veld mag niet leeg zijn";
      }
      if (oldPassword == null || oldPassword == "") {
        oldPwErrortext = "Dit veld mag niet leeg zijn";
      }

      //FireBase wachtwoord ophalen
      else if (oldPassword != "password") {
        oldPwErrortext = "Fout wachtwoord";
      } else if (oldPassword == "password" &&
          newPassword == confirmNewPassword &&
          newPassword != null &&
          newPassword != "") {
        oldPwController.clear();
        newPwController.clear();
        confirmNewPwController.clear();
        oldPassword = null;
        newPassword = null;
        confirmNewPassword = null;
        successMessage = "Wachtwoord succesvol gewijzigd";
        //Nieuw wachtwoord in firebase opslagen
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
            height: 30,
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
            width: 400.0,
            height: 90.0,
            margin: const EdgeInsets.symmetric(horizontal: 100.0),
            child: ElevatedButton(
                onPressed: _change,
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 227, 5, 20),
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
      required this.controller,
      Key? key})
      : super(key: key);

  final String labelText;
  final void Function(String)? onChanged;
  final String? errorText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 500.0,
        height: 110.0,
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          obscureText: true,
          cursorColor: const Color.fromARGB(255, 227, 5, 20),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(12, 24, 12, 20),
            labelText: labelText,
            errorText: errorText,
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
        ));
  }
}
