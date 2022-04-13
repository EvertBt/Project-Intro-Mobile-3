import 'dart:async';

import 'package:examen_app/config/constants.dart';
import 'package:examen_app/firebase/exammanager.dart';
import 'package:examen_app/firebase/model/exam.dart';
import 'package:examen_app/firebase/model/student.dart';
import 'package:flutter/material.dart';

Widget overview(
    BuildContext context,
    String apptitle,
    Student student,
    Exam exam,
    String progressText,
    double progress,
    int questionCount,
    Duration duration,
    Timer? _timer,
    Widget Function(int) _buildRow,
    void Function() handInExam) {
  return WillPopScope(
      onWillPop: () async {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text("Waarschuwing"),
            content: const Text(
                'Als je vragen hebt ingevuld wordt je examen ingediend\nen kan je het examen niet meer betreden'),
            actions: <Widget>[
              Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Annuleren'),
                    child: const Text('Annuleren'),
                    style: TextButton.styleFrom(
                      primary: buttonColor,
                      onSurface: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  TextButton(
                    onPressed: () async => {
                      await ExamManager.pushExamToStudent(exam, student)
                          .then((value) => {
                                Navigator.pop(
                                    context, 'Begrepen, verlaat examen'),
                                _timer!.cancel(),
                                Navigator.pushNamed(context, homeRoute)
                              }),
                    },
                    child: const Text('Begrepen, verlaat examen'),
                    style: TextButton.styleFrom(
                      primary: buttonColor,
                      onSurface: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Container()),
              Text(
                apptitle,
                style: const TextStyle(fontSize: 30),
              ),
              Expanded(child: Container()),
              Text(student.studentNr)
            ],
          ),
          backgroundColor: primaryColor,
        ),
        body: Center(
          child: Container(
            margin:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            width: 700.0,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.grey)],
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              children: [
                Container(
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
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(child: Container()),
                        Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: Text(
                            progressText,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 50),
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.grey,
                            color: buttonColor,
                            strokeWidth: 10,
                            value: progress,
                          ),
                        )
                      ],
                    )),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.only(bottom: 20, top: 20),
                  child: ListView.builder(
                      itemCount: questionCount,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildRow(index);
                      }),
                ))
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 56,
          color: primaryColor,
          child: Row(
            children: [
              Container(
                  width: 100.0,
                  height: 56.0,
                  padding: const EdgeInsets.only(left: 10.0),
                  decoration: const BoxDecoration(
                    color: primaryColor,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 13.0),
                    child: const Image(
                      image: AssetImage('assets/logosmall.png'),
                      filterQuality: FilterQuality.high,
                    ),
                  )),
              Expanded(
                child: Container(),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 140),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: const Icon(
                          Icons.timer,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Text(
                        duration
                            .toString()
                            .substring(0, duration.toString().length - 7),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ],
                  )),
              Expanded(
                child: Container(),
              ),
              Container(
                  decoration: const BoxDecoration(
                    color: primaryColor,
                  ),
                  height: 56.0,
                  width: 245.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 99, 7, 0),
                            blurRadius: 10,
                            offset: Offset(0, 5))
                      ],
                      color: buttonColor,
                    ),
                    child: TextButton(
                        onPressed: () {
                          handInExam();
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30))),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 15),
                              child: const Text(
                                "Examen Indienen",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                              child: const Icon(
                                Icons.book,
                                color: Colors.white,
                                size: 35,
                              ),
                              margin: const EdgeInsets.only(left: 15),
                            )
                          ],
                        )),
                  ))
            ],
          ),
        ),
      ));
}
