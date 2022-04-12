import 'package:examen_app/config/constants.dart';
import 'package:examen_app/firebase/exammanager.dart';
import 'package:examen_app/firebase/model/question.dart';
import 'package:flutter/material.dart';
import '../../firebase/model/exam.dart';
import '../../firebase/model/student.dart';

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
  String apptitle = "";
  int questionCount = 0;
  String progressText = "Voortgang: 0/0";
  double progress = 0.0;
  Question? selectedQuestion;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    exam = await ExamManager.getExam();
    apptitle = exam.title;
    seedData();
    questionCount = exam.questions!.length;
    updateProgress();
    setState(() {});
  }

  //TEMP
  void seedData() {
    exam.questions = <Question>[
      Question(answer: "yes"),
      Question(),
      Question(answer: "25"),
      Question(),
      Question(),
    ];
  }

  //call na "volgende vraag" en "overzicht vragen"
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
                  onPressed: () => {
                    Navigator.pop(context, 'Ja'),
                    //await update student in firestore,
                    Navigator.pushNamed(context, homeRoute)
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

  void openQuestion(Question question) {
    state = ExamState.question;
    selectedQuestion = question;
    setState(() {});
  }

  void showOverview() {
    state = ExamState.questionOverview;
    updateProgress();
    setState(() {});
  }

  IconData getProgressIcon(Question question) {
    if (question.answer != "") {
      return Icons.check_circle;
    } else {
      return Icons.create;
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case ExamState.questionOverview:
        return overview(context);
      case ExamState.question:
        return question(context, question: selectedQuestion);
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

  Widget overview(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text("Waarschuwing"),
              content: const Text(
                  'Als je het examen verlaat zonder in te dienen\nworden je antwoorden niet opgeslagen'),
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
                      onPressed: () => {
                        Navigator.pop(context, 'Begrepen, verlaat examen'),
                        //await update student in firestore,
                        Navigator.pushNamed(context, homeRoute)
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
                Text(widget.student.studentNr)
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

  Widget question(BuildContext context, {Question? question}) {
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
                Text(widget.student.studentNr)
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
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
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
                      Expanded(child: Container())
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
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
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
                      Expanded(child: Container())
                    ],
                  ),
                ),
              )
            ],
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
                    : Container()
              ],
            ),
          ),
        ));
  }
}
