import 'package:examen_app/config/constants.dart';
import 'package:examen_app/firebase/model/codecorrectionquestion.dart';
import 'package:examen_app/firebase/model/multiplechoicequestion.dart';
import 'package:examen_app/firebase/model/question.dart';
import 'package:examen_app/firebase/model/student.dart';
import 'package:examen_app/views/admin/admin_students.dart';
import 'package:examen_app/views/questions/codecorrection.dart';
import 'package:examen_app/views/questions/multiplechoice.dart';
import 'package:examen_app/views/questions/openquestion.dart';
import 'package:flutter/material.dart';

class AdminStudentAnswer extends StatefulWidget {
  const AdminStudentAnswer(
      {required this.question,
      required this.student,
      required this.switchState,
      Key? key})
      : super(key: key);

  final void Function(AdminStudentState) switchState;
  final Student? student;
  final Question? question;

  @override
  State<AdminStudentAnswer> createState() => _AdminStudentAnswer();
}

class _AdminStudentAnswer extends State<AdminStudentAnswer> {
  TextEditingController controller = TextEditingController();
  TextEditingController codeController = TextEditingController();
  Widget loadQuestion(
    BuildContext context,
    Question question,
  ) {
    if (question is MultipleChoiceQuestion) {
      return multipleChoiceQuestion(context, question);
    } else if (question is CodeCorrectionQuestion) {
      return codeCorrectionQuestion(context, question);
    } else {
      return openQuestion(context, question);
    }
  }

  Widget loadAnswer(BuildContext context, Question question,
      TextEditingController controller, TextEditingController codeController) {
    if (question is MultipleChoiceQuestion) {
      return MultipleChoiceAnswer(question: question);
    } else if (question is CodeCorrectionQuestion) {
      return codeCorrectionAnswer(context, question, codeController);
    } else {
      return openQuestionAnswer(context, question, controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          widget.switchState(AdminStudentState.studentDetails);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Container()),
                Text(
                  "Antwoord vraag ${widget.student!.exam!.questions!.indexOf(widget.question!) + 1}",
                  style: const TextStyle(fontSize: 30),
                ),
                Expanded(child: Container()),
                Text(widget.student!.studentNr)
              ],
            ),
            backgroundColor: primaryColor,
          ),
          body: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 15.0, bottom: 15.0, left: 20.0, right: 10.0),
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
                                child: Text(
                                  "Vraag ${widget.student!.exam!.questions!.indexOf(widget.question!) + 1}",
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )),
                      Expanded(
                          child: loadQuestion(
                              context,
                              widget.student!.exam!.questions![widget
                                  .student!.exam!.questions!
                                  .indexOf(widget.question!)]))
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(children: [
                  Expanded(child: Container(
                  margin: const EdgeInsets.only(
                      top: 15.0, bottom: 15.0, left: 10.0, right: 20.0),
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
                                  "Antwoord",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(child: Container()),
                            ],
                          )),
                      Expanded(
                          child: loadAnswer(
                              context,
                              widget.student!.exam!.questions![widget
                                  .student!.exam!.questions!
                                  .indexOf(widget.question!)],
                              controller,
                              codeController))
                    ],
                  ),
                ),),
                Expanded(child: Container(
                  margin: const EdgeInsets.only(
                      top: 15.0, bottom: 15.0, left: 10.0, right: 20.0),
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
                                  "Antwoord",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(child: Container()),
                            ],
                          )),
                      Expanded(
                          child: loadAnswer(
                              context,
                              widget.student!.exam!.questions![widget
                                  .student!.exam!.questions!
                                  .indexOf(widget.question!)],
                              controller,
                              codeController))
                    ],
                  ),
                ),)
                ],)
              )
            ],
          ), //bottomnavbar TEMP
        ));
  }
}
