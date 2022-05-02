import 'package:examen_app/config/constants.dart';
import 'package:examen_app/views/admin/admin_exam.dart';
import 'package:examen_app/helpers/widgets/button.dart';
import 'package:flutter/material.dart';

class AdminExamOpenEnded extends StatefulWidget {
  const AdminExamOpenEnded({required this.switchState, Key? key})
      : super(key: key);

  final void Function(AdminExamState) switchState;

  @override
  State<AdminExamOpenEnded> createState() => _AdminExamOpenEnded();
}

class _AdminExamOpenEnded extends State<AdminExamOpenEnded> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
              child: Text(
            'Open vraag toevoegen',
            style: TextStyle(fontSize: 30.0),
          )),
          backgroundColor: primaryColor,
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                  //flex: 4,
                  child: Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                          height: 70,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5,
                                    offset: Offset(0, 3))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25.0)),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Text(
                                  "Vragen",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )),
                      Expanded(
                          child: Container(
                              margin: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(23),
                                color: buttonColor,
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(3),
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 10, 30),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: const TextField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  style: TextStyle(fontSize: 25),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "vul hier het antwoord in"),
                                  cursorColor: buttonColor,
                                ),
                              )))
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                          height: 70,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5,
                                    offset: Offset(0, 3))
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25.0)),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: const Text(
                                  "Vragen",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )),
                      Expanded(
                          child: Container(
                              margin: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(23),
                                color: buttonColor,
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(3),
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 10, 30),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: const TextField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  style: TextStyle(fontSize: 25),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "vul hier het antwoord in"),
                                  cursorColor: buttonColor,
                                ),
                              )))
                    ],
                  ))
                ],
              )),
              CustomButton(
                width: 600,
                height: 80,
                buttonColor: buttonColor,
                onPressed: () {},
                margin: const EdgeInsets.symmetric(vertical: 30),
                padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
                buttonText: "Vraag opslaan",
                fontSize: 35,
                borderRadius: 25,
                icon: const Icon(
                  Icons.save,
                  size: 45,
                ),
              )
            ],
          ),
        ));
  }
}
