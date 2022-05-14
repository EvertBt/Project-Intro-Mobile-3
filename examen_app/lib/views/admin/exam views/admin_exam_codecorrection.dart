import 'package:examen_app/config/constants.dart';
import 'package:examen_app/firebase/model/codecorrectionquestion.dart';
import 'package:examen_app/helpers/widgets/button.dart';
import 'package:examen_app/helpers/widgets/codeditor.dart';
import 'package:examen_app/views/admin/admin_exam.dart';
import 'package:examen_app/views/admin/admin_start.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminExamCodeCorrection extends StatefulWidget {
  const AdminExamCodeCorrection({required this.switchState, Key? key})
      : super(key: key);

  static String question = "";
  static String answer = "";
  static int score = 0;
  static int maxScore = 0;

  final void Function(AdminExamState) switchState;

  @override
  State<AdminExamCodeCorrection> createState() => _AdminExamCodeCorrection();
}

class _AdminExamCodeCorrection extends State<AdminExamCodeCorrection> {
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  TextEditingController maxScoreController = TextEditingController();

  CodeCorrectionQuestion question = CodeCorrectionQuestion();

  @override
  void initState() {
    super.initState();

    questionController.text = AdminStart.selectedQuestion!.question;
    maxScoreController.text = AdminStart.selectedQuestion!.maxScore.toString();
    answerController.text = AdminStart.selectedQuestion!.answer;
  }

  String getMaxScore() {
    if (AdminStart.selectedQuestion!.maxScore.isNaN) {
      AdminExamCodeCorrection.maxScore = 1;
    } else {
      AdminExamCodeCorrection.maxScore = AdminStart.selectedQuestion!.maxScore;
    }
    return AdminExamCodeCorrection.maxScore.toString();
  }

  int parseMaxScore(String value) {
    if (value.isEmpty) {
      return 0;
    } else {
      return int.parse(value);
    }
  }

  void saveQuestion() {
    AdminExamCodeCorrection.question = questionController.text;
    AdminExamCodeCorrection.maxScore = parseMaxScore(maxScoreController.text);
    AdminExamCodeCorrection.answer = answerController.text;

    AdminStart.selectedQuestion!.question = questionController.text;
    AdminStart.selectedQuestion!.answer = answerController.text;
    AdminStart.selectedQuestion!.maxScore = AdminExamCodeCorrection.maxScore;
    AdminStart.selectedQuestion!.score = AdminExamCodeCorrection.score;

    if (!AdminStart.exam.questions!.contains(AdminStart.selectedQuestion)) {
      AdminStart.exam.questions!.add(AdminStart.selectedQuestion!);
    }

    widget.switchState(AdminExamState.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () => {widget.switchState(AdminExamState.home)},
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          style: TextButton.styleFrom(
            primary: buttonColor,
            onSurface: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Code correction vraag toevoegen',
            style: TextStyle(fontSize: 30.0),
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(20, 20, 10, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(blurRadius: 5, color: Colors.grey)
                        ],
                        borderRadius: BorderRadius.circular(25),
                      ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 50),
                                  child: const Text(
                                    "Vraag",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      child: const Text(
                                        "Score:",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 10, 30, 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(23),
                                        color: buttonColor,
                                      ),
                                      child: Container(
                                        width: 60,
                                        margin: const EdgeInsets.all(3),
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 18, 0, 0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                        ),
                                        child: TextField(
                                          controller: maxScoreController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          maxLines: 1,
                                          maxLength: 2,
                                          style: const TextStyle(fontSize: 25),
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: getMaxScore(),
                                              counterText: ""),
                                          cursorColor: buttonColor,
                                          onChanged: (value) => {
                                            AdminExamCodeCorrection.maxScore =
                                                parseMaxScore(value)
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
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
                                    const EdgeInsets.fromLTRB(20, 10, 20, 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: CodeEditor(
                                  controller: questionController,
                                  question: question,
                                  isQuestion: true,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(20, 20, 10, 0),
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
                                    const EdgeInsets.fromLTRB(20, 10, 20, 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: CodeEditor(
                                  controller: answerController,
                                  question: question,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            CustomButton(
              width: 600,
              height: 80,
              buttonColor: buttonColor,
              onPressed: () {
                saveQuestion();
              },
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
      ),
    );
  }
}
