import 'package:examen_app/config/constants.dart';
import 'package:examen_app/firebase/model/codecorrectionquestion.dart';
import 'package:examen_app/firebase/model/multiplechoicequestion.dart';
import 'package:examen_app/firebase/model/question.dart';
import 'package:examen_app/views/admin/admin_start.dart';
import 'package:examen_app/views/admin/admin_students.dart';
import 'package:examen_app/views/questions/codecorrection.dart';
import 'package:examen_app/views/questions/multiplechoice.dart';
import 'package:examen_app/views/questions/openquestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminStudentAnswer extends StatefulWidget {
  const AdminStudentAnswer({required this.switchState, Key? key})
      : super(key: key);

  final void Function(AdminStudentState) switchState;

  @override
  State<AdminStudentAnswer> createState() => _AdminStudentAnswer();
}

class _AdminStudentAnswer extends State<AdminStudentAnswer> {
  TextEditingController studentController = TextEditingController();
  TextEditingController correctController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController scoreController = TextEditingController();

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
      return codeCorrectionQuestion(context, question, isExam: false);
    } else {
      return openQuestionAnswer(context, question, controller);
    }
  }

  @override
  void initState() {
    studentController.text = "!empty!";
    correctController.text = "!empty!";
    scoreController.text = AdminStart.selectedQuestion!.score.toString();
    super.initState();
  }

  int parseScore(String value) {
    if (value.isEmpty) {
      return 0;
    } else {
      return int.parse(value);
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
                IconButton(
                  onPressed: () =>
                      widget.switchState(AdminStudentState.studentDetails),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                Expanded(child: Container()),
                Text(
                  "Antwoord vraag ${AdminStart.selectedStudent!.exam!.questions!.indexOf(AdminStart.selectedQuestion!) + 1}",
                  style: const TextStyle(fontSize: 30),
                ),
                Expanded(child: Container()),
                Text(AdminStart.selectedStudent!.studentNr)
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
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 50),
                                child: Text(
                                  "Vraag ${AdminStart.selectedStudent!.exam!.questions!.indexOf(AdminStart.selectedQuestion!) + 1}",
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 10, 30, 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(23),
                                  color: buttonColor,
                                ),
                                child: Container(
                                  width: 125,
                                  margin: const EdgeInsets.all(3),
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          textAlign: TextAlign.right,
                                          controller: scoreController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          maxLines: 1,
                                          maxLength: 2,
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              counterText: ""),
                                          cursorColor: buttonColor,
                                          onChanged: (value) => {
                                            AdminStart.selectedQuestion!.score =
                                                parseScore(value)
                                          },
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 20, 0),
                                        child: Text(
                                          "/${AdminStart.selectedQuestion!.maxScore}",
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Expanded(
                        child: loadQuestion(
                          context,
                          AdminStart.exam.questions![AdminStart
                              .selectedStudent!.exam!.questions!
                              .indexOf(AdminStart.selectedQuestion!)],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 15.0, bottom: 15.0, left: 10.0, right: 20.0),
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
                                      "Antwoord student",
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
                                  AdminStart.selectedQuestion!,
                                  studentController,
                                  codeController))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 0, bottom: 15.0, left: 10.0, right: 20.0),
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
                                      "Correct antwoord",
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
                                  AdminStart.exam.questions![AdminStart
                                      .selectedStudent!.exam!.questions!
                                      .indexOf(AdminStart.selectedQuestion!)],
                                  correctController,
                                  codeController))
                        ],
                      ),
                    ),
                  )
                ],
              ))
            ],
          ),
        ));
  }
}
