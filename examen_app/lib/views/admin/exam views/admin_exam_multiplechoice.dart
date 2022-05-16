import 'package:examen_app/config/constants.dart';
import 'package:examen_app/firebase/model/multiplechoicequestion.dart';
import 'package:examen_app/helpers/widgets/button.dart';
import 'package:examen_app/views/admin/admin_exam.dart';
import 'package:examen_app/views/admin/admin_start.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminExamMultipleChoice extends StatefulWidget {
  const AdminExamMultipleChoice({required this.switchState, Key? key})
      : super(key: key);

  static String question = "";
  static String answer = "";
  static List<String> options = [];
  static int score = 0;
  static int maxScore = 0;

  static int answerIndex = 0;
  static int nextIndex = 0;

  final void Function(AdminExamState) switchState;

  @override
  State<AdminExamMultipleChoice> createState() => _AdminExamMultipleChoice();
}

class _AdminExamMultipleChoice extends State<AdminExamMultipleChoice> {
  TextEditingController questionController = TextEditingController();
  TextEditingController maxScoreController = TextEditingController();

  List<TextEditingController> optionsControllers = [];

  MultipleChoiceQuestion? question;

  @override
  void initState() {
    super.initState();

    AdminExamMultipleChoice.options = [];
    optionsControllers = [];

    question = AdminStart.selectedQuestion as MultipleChoiceQuestion;

    for (var option in question!.options!) {
      AdminExamMultipleChoice.options.add(option);
      optionsControllers.add(TextEditingController());
    }

    AdminExamMultipleChoice.answer = AdminStart.selectedQuestion!.answer;

    AdminExamMultipleChoice.answerIndex = getAnswerIndex();
    AdminExamMultipleChoice.nextIndex = getOptionsCount();

    questionController.text = AdminStart.selectedQuestion!.question;
    maxScoreController.text = AdminStart.selectedQuestion!.maxScore.toString();
  }

  int getAnswerIndex() {
    for (int i = 0; i < getOptionsCount(); i++) {
      if (AdminExamMultipleChoice.options[i] ==
          AdminExamMultipleChoice.answer) {
        return i;
      }
    }
    return 0;
  }

  String getQuestion() {
    if (AdminStart.selectedQuestion!.question == "") {
      AdminExamMultipleChoice.question = "vul hier de vraag in";
    } else {
      AdminExamMultipleChoice.question = AdminStart.selectedQuestion!.question;
    }
    return AdminExamMultipleChoice.question;
  }

  String getMaxScore() {
    if (AdminStart.selectedQuestion!.maxScore.isNaN) {
      AdminExamMultipleChoice.maxScore = 1;
    } else {
      AdminExamMultipleChoice.maxScore = AdminStart.selectedQuestion!.maxScore;
    }
    return AdminExamMultipleChoice.maxScore.toString();
  }

  int parseMaxScore(String value) {
    if (value.isEmpty) {
      return 0;
    } else {
      return int.parse(value);
    }
  }

  String getOption(int i) {
    if (AdminExamMultipleChoice.options.isNotEmpty) {
      optionsControllers[i].text = AdminExamMultipleChoice.options[i];
      return AdminExamMultipleChoice.options[i];
    }
    return "";
  }

  int getOptionsCount() {
    return AdminExamMultipleChoice.options.length;
  }

  Color getOptionColor(int i) {
    if (AdminExamMultipleChoice.options[i] == AdminExamMultipleChoice.answer) {
      if (AdminExamMultipleChoice.answerIndex == i) {
        return const Color.fromRGBO(100, 221, 23, 1.0);
      }
      return Colors.orange;
    }
    return Colors.white;
  }

  void removeOption(int i) {
    if (i != AdminExamMultipleChoice.answerIndex) {
      if (getOptionsCount() > 1) {
        AdminExamMultipleChoice.options.removeAt(i);
        optionsControllers.removeAt(i);

        if (AdminExamMultipleChoice.answerIndex > i) {
          AdminExamMultipleChoice.answerIndex--;
        }

        setState(() {});
      }
    }
  }

  void addOption() {
    AdminExamMultipleChoice.nextIndex++;
    String option = "optie ${AdminExamMultipleChoice.nextIndex}";
    AdminExamMultipleChoice.options.add(option);
    optionsControllers.add(TextEditingController());

    setState(() {});
  }

  void setAnswer(int i) {
    AdminExamMultipleChoice.answer = AdminExamMultipleChoice.options[i];
    AdminExamMultipleChoice.answerIndex = i;
    setState(() {});
  }

  bool checkValidAnswers() {
    AdminExamMultipleChoice.question = questionController.text;
    AdminExamMultipleChoice.maxScore = parseMaxScore(maxScoreController.text);
    setState(() {});
    for (int i = 0; i < getOptionsCount(); i++) {
      for (int j = i + 1; j < getOptionsCount(); j++) {
        //multiple options are the answer
        if (AdminExamMultipleChoice.options[i] ==
            AdminExamMultipleChoice.options[j]) {
          if (AdminExamMultipleChoice.options[i] ==
              AdminExamMultipleChoice.answer) {
            return true;
          }
        }
      }
    }
    return false;
  }

  void saveQuestion() {
    if (!checkValidAnswers()) {
      print(AdminExamMultipleChoice.answer);

      AdminStart.selectedQuestion!.question = AdminExamMultipleChoice.question;
      AdminStart.selectedQuestion!.answer = AdminExamMultipleChoice.answer;
      question!.options = AdminExamMultipleChoice.options;
      AdminStart.selectedQuestion!.maxScore = AdminExamMultipleChoice.maxScore;
      AdminStart.selectedQuestion!.score = AdminExamMultipleChoice.score;

      if (!AdminStart.exam.questions!.contains(AdminStart.selectedQuestion)) {
        AdminStart.exam.questions!.add(AdminStart.selectedQuestion!);
      }

      widget.switchState(AdminExamState.home);
    }
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
            'Multiple choice vraag toevoegen',
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
                                  offset: Offset(0, 3),
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25.0),
                            ),
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
                                            AdminExamMultipleChoice.maxScore =
                                                parseMaxScore(value)
                                          },
                                        ),
                                      ),
                                    ),
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
                                    const EdgeInsets.fromLTRB(20, 10, 10, 30),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: TextField(
                                  controller: questionController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  style: const TextStyle(fontSize: 25),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: getQuestion()),
                                  cursorColor: buttonColor,
                                  onChanged: (value) =>
                                      AdminExamMultipleChoice.question = value,
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
                                      "Opties",
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
                                    const EdgeInsets.fromLTRB(10, 10, 10, 30),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Container(
                                  height: 400,
                                  color: Colors.white,
                                  padding: const EdgeInsets.only(
                                      bottom: 20, top: 20),
                                  child: ListView.builder(
                                      itemCount: getOptionsCount(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        if (index < getOptionsCount() - 1) {
                                          return _buildOptionsColumn(index);
                                        } else {
                                          return _buildOptionsEndColumn(index);
                                        }
                                      }),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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

  Widget _buildOptionsColumn(int i) {
    return Container(
      width: double.infinity,
      height: 75.0,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        color: buttonColor,
      ),
      child: Container(
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(blurRadius: 5, color: Colors.grey)
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CustomButton(
                  width: double.infinity,
                  height: 75,
                  buttonColor: getOptionColor(i),
                  onPressed: () {
                    setAnswer(i);
                  },
                  padding: const EdgeInsets.fromLTRB(23, 10, 17, 10),
                  borderRadius: 19,
                  buttonText: (i + 1).toString(),
                  textColor: Colors.black,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              width: 545,
              child: TextField(
                controller: optionsControllers[i],
                keyboardType: TextInputType.multiline,
                maxLines: 1,
                style: const TextStyle(fontSize: 25),
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: getOption(i)),
                cursorColor: buttonColor,
                onChanged: (value) => {
                  AdminExamMultipleChoice.options[i] = value,
                  if (i == AdminExamMultipleChoice.answerIndex)
                    {AdminExamMultipleChoice.answer = value},
                },
              ),
            ),
            Container(
              width: 80,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: buttonColor,
              ),
              child: SizedBox(
                width: 80,
                height: double.infinity,
                child: CustomButton(
                  width: double.infinity,
                  height: 75,
                  buttonColor: buttonColor,
                  onPressed: () {
                    removeOption(i);
                  },
                  padding: const EdgeInsets.fromLTRB(0, 10, 17, 10),
                  borderRadius: 19,
                  icon: const Icon(
                    Icons.remove,
                    size: 45,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionsEndColumn(int i) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 75.0,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23),
            color: buttonColor,
          ),
          child: Container(
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(blurRadius: 5, color: Colors.grey)
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: CustomButton(
                      width: double.infinity,
                      height: 75,
                      buttonColor: getOptionColor(i),
                      onPressed: () {
                        setAnswer(i);
                      },
                      padding: const EdgeInsets.fromLTRB(23, 10, 17, 10),
                      borderRadius: 19,
                      buttonText: (i + 1).toString(),
                      textColor: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  width: 545,
                  child: TextField(
                    controller: optionsControllers[i],
                    keyboardType: TextInputType.multiline,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 25),
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: getOption(i)),
                    cursorColor: buttonColor,
                    onChanged: (value) => {
                      AdminExamMultipleChoice.options[i] = value,
                      if (i == AdminExamMultipleChoice.answerIndex)
                        {AdminExamMultipleChoice.answer = value},
                    },
                  ),
                ),
                SizedBox(
                  width: 80,
                  height: double.infinity,
                  child: CustomButton(
                    width: double.infinity,
                    height: 75,
                    buttonColor: buttonColor,
                    onPressed: () {
                      removeOption(i);
                    },
                    padding: const EdgeInsets.fromLTRB(0, 10, 17, 10),
                    borderRadius: 19,
                    icon: const Icon(
                      Icons.remove,
                      size: 45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        CustomButton(
          width: double.infinity,
          height: 75,
          buttonColor: buttonColor,
          onPressed: () {
            addOption();
          },
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          padding: const EdgeInsets.fromLTRB(20, 10, 328, 10),
          borderRadius: 25,
          icon: const Icon(
            Icons.add,
            size: 45,
          ),
        )
      ],
    );
  }
}
