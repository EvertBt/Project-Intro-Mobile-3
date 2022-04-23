import 'package:code_editor/code_editor.dart';
import 'package:examen_app/config/constants.dart';
import 'package:examen_app/firebase/model/codecorrectionquestion.dart';
import 'package:examen_app/firebase/model/exam.dart';
import 'package:examen_app/firebase/model/multiplechoicequestion.dart';
import 'package:examen_app/firebase/model/question.dart';
import 'package:examen_app/firebase/model/student.dart';
import 'package:examen_app/views/questions/codecorrection.dart';
import 'package:examen_app/views/questions/multiplechoice.dart';
import 'package:examen_app/views/questions/openquestion.dart';
import 'package:examen_app/views/student/exam/student_exam.dart';
import 'package:flutter/material.dart';

Widget loadQuestion(
  BuildContext context,
  Question question,
  EditorModel model,
) {
  if (question is MultipleChoiceQuestion) {
    return multipleChoiceQuestion(context, question);
  } else if (question is CodeCorrectionQuestion) {
    return codeCorrectionQuestion(context, question, model);
  } else {
    return openQuestion(context, question);
  }
}

Widget loadAnswer(BuildContext context, Question question,
    TextEditingController controller, TextEditingController codeController) {
  if (question is MultipleChoiceQuestion) {
    return multipleChoiceAnswer(context, question);
  } else if (question is CodeCorrectionQuestion) {
    return codeCorrectionAnswer(context, question, codeController);
  } else {
    return openQuestionAnswer(context, question, controller);
  }
}

Widget question(
    BuildContext context,
    void Function() showOverview,
    void Function(Question) openQuestion,
    String apptitle,
    String progressText,
    double progress,
    Student student,
    Exam exam,
    ExamState state,
    LastState lastState,
    TextEditingController controller,
    TextEditingController codeController,
    EditorModel model,
    {Question? question}) {
  return WillPopScope(
      onWillPop: () async {
        showOverview();
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
                                "Vraag ${exam.questions!.indexOf(question!) + 1}",
                                style: const TextStyle(
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
                              margin: const EdgeInsets.only(right: 17),
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
                    Expanded(child: loadQuestion(context, question, model))
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
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
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(child: Container()),
                            exam.questions!.indexOf(question) + 1 <
                                    exam.questions!.length
                                ? Container(
                                    width: 250.0,
                                    height: 50.0,
                                    margin: const EdgeInsets.only(right: 10),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          openQuestion(exam.questions![exam
                                                  .questions!
                                                  .indexOf(question) +
                                              1]);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: buttonColor,
                                          onPrimary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          padding: const EdgeInsets.all(8.0),
                                          elevation: 5,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 15),
                                              child: const Text(
                                                'Volgende vraag',
                                                style:
                                                    TextStyle(fontSize: 25.0),
                                              ),
                                            ),
                                            Expanded(child: Container()),
                                            const Icon(
                                              Icons.arrow_circle_right,
                                              size: 35,
                                            )
                                          ],
                                        )),
                                  )
                                : Container(
                                    width: 285.0,
                                    height: 50.0,
                                    margin: const EdgeInsets.only(right: 10),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          showOverview();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: buttonColor,
                                          onPrimary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          padding: const EdgeInsets.all(8.0),
                                          elevation: 5,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 15),
                                              child: const Text(
                                                'Vragen overzicht',
                                                style:
                                                    TextStyle(fontSize: 25.0),
                                              ),
                                            ),
                                            Expanded(child: Container()),
                                            Container(
                                                margin: const EdgeInsets.only(
                                                    right: 15),
                                                child: const Icon(
                                                  Icons.auto_stories,
                                                  size: 35,
                                                ))
                                          ],
                                        )),
                                  ),
                          ],
                        )),
                    Expanded(
                        child: loadAnswer(
                            context, question, controller, codeController))
                  ],
                ),
              ),
            )
          ],
        ), //bottomnavbar TEMP
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
                        exam.duration
                            .toString()
                            .substring(0, exam.duration.toString().length - 7),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ],
                  )),
              Expanded(
                child: Container(),
              ),
              exam.questions!.indexOf(question) + 1 < exam.questions!.length
                  ? Container(
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
                              showOverview();
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
                                    "Vragen overzicht",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Container(
                                  child: const Icon(
                                    Icons.auto_stories,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  margin: const EdgeInsets.only(left: 15),
                                )
                              ],
                            )),
                      ))
                  : Container(width: 245.0)
            ],
          ),
        ),
      ));
}
