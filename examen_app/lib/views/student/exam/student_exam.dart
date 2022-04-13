import 'package:examen_app/config/constants.dart';
import 'package:examen_app/firebase/exammanager.dart';
import 'package:examen_app/firebase/model/exam.dart';
import 'package:examen_app/firebase/model/question.dart';
import 'package:examen_app/firebase/model/student.dart';
import 'package:examen_app/views/student/exam/overview.dart';
import 'package:examen_app/views/student/exam/questionview.dart';
import 'package:flutter/material.dart';
import 'dart:async';

enum ExamState { questionOverview, question }

class StudentExam extends StatefulWidget {
  const StudentExam({required this.student, Key? key}) : super(key: key);

  final Student student;

  @override
  State<StudentExam> createState() => _StudentExam();
}

class _StudentExam extends State<StudentExam> {
  ExamState state = ExamState.questionOverview;
  Exam exam = Exam();
  String apptitle = '';
  int questionCount = 0;
  String progressText = 'Voortgang: 0/0';
  double progress = 0.0;
  Timer? _timer;
  Question? selectedQuestion;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  void getData() async {
    await ExamManager.getExamFromStudent(widget.student).then((value) => {
          exam = value,
          apptitle = exam.title,
          questionCount = exam.questions!.length,
          updateProgress(),
          if (!alreadyEntered()) {startTimer()},
          setState(() {})
        });
  }

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (exam.duration == const Duration(seconds: 0)) {
          setState(() {
            forceEndExam();
            timer.cancel();
          });
        } else {
          setState(() {
            exam.duration = Duration(seconds: exam.duration.inSeconds - 1);
          });
        }
      },
    );
  }

  void updateProgress() {
    int completed = 0;
    for (Question question in exam.questions!) {
      if (question.answer != "") {
        completed++;
      }
    }
    progressText = "Voortgang: $completed/$questionCount";
    progress = completed / questionCount;
    setState(() {});
  }

  void handInExam() async {
    if (progress == 1) {
      widget.student.exam = exam;
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: const Text('Ben je zeker dat je wil indienen?'),
          actions: <Widget>[
            Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Nee'),
                  child: const Text('Nee'),
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
                    await ExamManager.pushExamToStudent(exam, widget.student)
                        .then((value) => {
                              Navigator.pop(context, 'Ja'),
                              _timer!.cancel(),
                              Navigator.pushNamed(context, homeRoute)
                            })
                  },
                  child: const Text('Ja'),
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
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: const Text('Gelieve alle vragen te beantwoorden'),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
                style: TextButton.styleFrom(
                  primary: buttonColor,
                  onSurface: Colors.white,
                )),
          ],
        ),
      );
    }
  }

  void forceEndExam() async {
    widget.student.exam = exam;
    showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: AlertDialog(
                title: const Text('Tijdslimiet bereikt'),
                content: const Text(
                    'Al je ingevulde vragen worden automatisch ingediend.\nJe zal het examen nu verlaten'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async => {
                      await ExamManager.pushExamToStudent(exam, widget.student)
                          .then((value) => {
                                Navigator.pop(context, 'Ok'),
                                Navigator.pushNamed(context, homeRoute)
                              })
                    },
                    child: const Text('Ok'),
                    style: TextButton.styleFrom(
                      primary: buttonColor,
                      onSurface: Colors.white,
                    ),
                  ),
                ],
              ));
        });
  }

  bool alreadyEntered() {
    for (Question question in exam.questions!) {
      if (question.answer != "") {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: AlertDialog(
                    title: const Text('Examen al ingediend'),
                    content: const Text(
                        'Je hebt dit examen al ingediend.\nJe zal terug naar het homescherm gebracht worden'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => {
                          Navigator.pop(context, 'Ok'),
                          Navigator.pushNamed(context, homeRoute)
                        },
                        child: const Text('Ok'),
                        style: TextButton.styleFrom(
                          primary: buttonColor,
                          onSurface: Colors.white,
                        ),
                      ),
                    ],
                  ));
            });
        return true;
      }
    }
    return false;
  }

  void openQuestion(Question question) {
    state = ExamState.question;
    selectedQuestion = question;
    updateProgress();
    setState(() {});
  }

  void showOverview() {
    state = ExamState.questionOverview;
    updateProgress();
    setState(() {});
  }

  IconData getProgressIcon(Question question) {
    if (question.answer != '') {
      return Icons.check_circle;
    } else {
      return Icons.create;
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case ExamState.questionOverview:
        return overview(
            context,
            apptitle,
            widget.student,
            exam,
            progressText,
            progress,
            questionCount,
            exam.duration,
            _timer,
            _buildRow,
            handInExam);
      case ExamState.question:
        return question(context, showOverview, openQuestion, apptitle,
            progressText, progress, widget.student, exam,
            question: selectedQuestion);
    }
  }

  Widget _buildRow(int i) {
    return Container(
      width: double.infinity,
      height: 75.0,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: ElevatedButton(
          onPressed: () {
            openQuestion(exam.questions![i]);
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
                child: Icon(
                  getProgressIcon(exam.questions![i]),
                  size: 35,
                ),
              )
            ],
          )),
    );
  }
}
