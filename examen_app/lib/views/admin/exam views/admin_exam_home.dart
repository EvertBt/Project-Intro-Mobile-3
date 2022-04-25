import 'package:examen_app/config/constants.dart';
import 'package:examen_app/firebase/exammanager.dart';
import 'package:examen_app/firebase/model/exam.dart';
import 'package:examen_app/firebase/model/question.dart';
import 'package:examen_app/views/admin/admin_exam.dart';
import 'package:flutter/material.dart';

class AdminExamHome extends StatefulWidget {
  const AdminExamHome({required this.switchState, Key? key}) : super(key: key);

  final void Function(AdminExamState) switchState;

  @override
  State<AdminExamHome> createState() => _AdminExamHome();
}

class _AdminExamHome extends State<AdminExamHome> {
  Exam exam = Exam();

  @override
  void initState() {
    super.initState();
    //getExam();
    _loadData();
  }

  void _loadData() async {
    await ExamManager.getExam().then((value) =>
        {exam = value, print("exam: ${exam.title}"), setState(() {})});
  }

  // void getExam() async {
  //   exam = await ExamManager.getExam();
  //   print("question length: ${exam!.questions!.length}");
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
              child: Text(
            'Examen',
            style: TextStyle(fontSize: 30.0),
          )),
          backgroundColor: primaryColor,
        ),
        body: Center(
          child: Row(children: [
            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                width: 700.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(blurRadius: 5, color: Colors.grey)
                    ],
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
                          ],
                        )),
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.only(bottom: 20, top: 20),
                      child: ListView.builder(
                          itemCount: exam.questions?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildRow(index);
                          }),
                    ))
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                          width: 700.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(blurRadius: 5, color: Colors.grey)
                              ],
                              borderRadius: BorderRadius.circular(25)),
                          child: Container(
                            margin: const EdgeInsets.only(top: 15),
                            child: const Text(
                              "Tijdslimiet",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 5,
                        child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 20.0),
                            width: 700.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(blurRadius: 5, color: Colors.grey)
                                ],
                                borderRadius: BorderRadius.circular(25)),
                            child: Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: const Text(
                                "Vraag toevoegen",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            )))
                  ],
                ))
          ]),
        ));
  }

  Widget _buildRow(int i) {
    return Container(
      width: double.infinity,
      height: 75.0,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: ElevatedButton(
          onPressed: () {
            //editQuestion(i);
          },
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
            onPrimary: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.all(8.0),
            elevation: 5,
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Text(
                  "Vraag ${i + 1}",
                  style: const TextStyle(fontSize: 30.0),
                ),
              ),
              Expanded(child: Container()),
              Container(
                margin: const EdgeInsets.only(right: 20),
                // child: Icon(
                //   getProgressIcon(exam.questions![i]),
                //   size: 35,
                // ),
              )
            ],
          )),
    );
  }

  void editQuestion(Question question) {}
}
