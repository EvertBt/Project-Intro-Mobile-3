import 'package:duration_picker/duration_picker.dart';
import 'package:examen_app/config/constants.dart';
import 'package:examen_app/firebase/exammanager.dart';
import 'package:examen_app/firebase/model/codecorrectionquestion.dart';
import 'package:examen_app/firebase/model/multiplechoicequestion.dart';
import 'package:examen_app/firebase/model/question.dart';
import 'package:examen_app/helpers/widgets/button.dart';
import 'package:examen_app/views/admin/admin_exam.dart';
import 'package:examen_app/views/admin/admin_start.dart';
import 'package:flutter/material.dart';

class AdminExamHome extends StatefulWidget {
  const AdminExamHome({required this.switchState, Key? key}) : super(key: key);

  static String title = "";
  static Duration duration = Duration();

  final void Function(AdminExamState) switchState;

  @override
  State<AdminExamHome> createState() => _AdminExamHome();
}

class _AdminExamHome extends State<AdminExamHome> {
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();

    titleController.text = getTitle();
    AdminExamHome.duration = AdminStart.exam.duration;
  }

  void editQuestion() {
    switch (AdminStart.selectedQuestion!.type) {
      case "open":
        //print("pressed on open ended question");
        widget.switchState(AdminExamState.openEnded);
        break;
      case "multiplechoice":
        //print("pressed on multiple choice question");
        widget.switchState(AdminExamState.multipleChoice);
        break;
      case "codecorrection":
        //print("pressed on code correction question");
        widget.switchState(AdminExamState.codeCorrection);
        break;
      default:
    }
  }

  Duration getTimelimit() {
    return AdminExamHome.duration;
  }

  String getTitle() {
    if (AdminStart.exam.title == "") {
      return "Title";
    }
    return AdminStart.exam.title;
  }

  void removeQuestion(int i) {
    AdminStart.exam.questions!.removeAt(i);
    setState(() {});
  }

  void resetExam() async {
    AdminStart.exam = await ExamManager.getExam();
    AdminExamHome.duration = AdminStart.exam.duration;
    setState(() {});
  }

  void removeQuestions() {
    AdminStart.exam.questions = [];
    setState(() {});
  }

  void addOpenEnded() {
    Question newOpenEnded = Question();
    AdminStart.selectedQuestion = newOpenEnded;
    widget.switchState(AdminExamState.openEnded);
  }

  void addMultipleChoice() {
    MultipleChoiceQuestion newMultipleChoice =
        MultipleChoiceQuestion(options: ["optie 1"], answer: "optie 1");
    AdminStart.selectedQuestion = newMultipleChoice;
    widget.switchState(AdminExamState.multipleChoice);
  }

  void addCodeCorrection() {
    CodeCorrectionQuestion newCodeCorrection = CodeCorrectionQuestion();
    AdminStart.selectedQuestion = newCodeCorrection;
    widget.switchState(AdminExamState.codeCorrection);
  }

  void saveExam() {
    AdminStart.exam.title = AdminExamHome.title;
    AdminStart.exam.duration = AdminExamHome.duration;
    ExamManager.addNewExam(AdminStart.students, AdminStart.exam);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Examen',
            style: TextStyle(fontSize: 30.0),
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Container(
                    height: 70,
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(20, 20, 10, 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(blurRadius: 5, color: Colors.grey)
                      ],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: const Text(
                            "Titel:",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 30, 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23),
                            color: buttonColor,
                          ),
                          child: Container(
                            width: 250,
                            margin: const EdgeInsets.all(3),
                            padding: const EdgeInsets.fromLTRB(15, 18, 0, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: titleController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 1,
                              style: const TextStyle(fontSize: 25),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: getTitle(),
                                  counterText: ""),
                              cursorColor: buttonColor,
                              onChanged: (value) =>
                                  {AdminExamHome.title = value},
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                        Container(
                          width: 60,
                          margin: const EdgeInsets.fromLTRB(0, 5, 30, 5),
                          child: CustomButton(
                            width: double.infinity,
                            height: 75,
                            buttonColor: buttonColor,
                            onPressed: () {
                              titleController.text = AdminStart.exam.title;
                              resetExam();
                            },
                            padding: const EdgeInsets.fromLTRB(0, 7, 7, 10),
                            borderRadius: 19,
                            icon: const Icon(
                              Icons.refresh,
                              size: 45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                      width: double.infinity,
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
                                borderRadius: BorderRadius.circular(25.0)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 30),
                                    child: const Text(
                                      "Vragen",
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Container(
                              padding:
                                  const EdgeInsets.only(bottom: 20, top: 20),
                              child: ListView.builder(
                                itemCount: AdminStart.exam.questions?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return _buildQuestionsColumn(index);
                                },
                              ),
                            ),
                          ),
                          Container(
                            height: 80,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(),
                                ),
                                Container(
                                  width: 80,
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 20, 20),
                                  child: CustomButton(
                                    width: double.infinity,
                                    height: 75,
                                    buttonColor: buttonColor,
                                    onPressed: () {
                                      removeQuestions();
                                    },
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 10, 17, 10),
                                    borderRadius: 19,
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 45,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 20, 20, 10),
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
                            width: double.infinity,
                            height: 70,
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(blurRadius: 5, color: Colors.grey)
                              ],
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Container(
                              width: 250,
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              child: const Text(
                                "Tijdslimiet",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: DurationPicker(
                                duration: AdminExamHome.duration,
                                onChange: (value) => {
                                  setState(() => AdminExamHome.duration = value)
                                },
                                snapToMins: 5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 20, 10),
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
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(blurRadius: 5, color: Colors.grey)
                              ],
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              child: const Text(
                                "Vraag toevoegen",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: CustomButton(
                                width: double.infinity,
                                height: 0,
                                buttonColor: buttonColor,
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 30, 10),
                                buttonText: "Open ended",
                                fontSize: 35,
                                borderRadius: 25,
                                icon: const Icon(
                                  Icons.text_snippet,
                                  size: 45,
                                ),
                                onPressed: () {
                                  addOpenEnded();
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: CustomButton(
                                width: double.infinity,
                                height: 0,
                                buttonColor: buttonColor,
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 30, 10),
                                buttonText: "Multiple choice",
                                fontSize: 35,
                                borderRadius: 25,
                                icon: const Icon(
                                  Icons.format_list_bulleted,
                                  size: 45,
                                ),
                                onPressed: () {
                                  addMultipleChoice();
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: CustomButton(
                                width: double.infinity,
                                height: 0,
                                buttonColor: buttonColor,
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 30, 10),
                                buttonText: "Code correction",
                                fontSize: 35,
                                borderRadius: 25,
                                icon: const Icon(
                                  Icons.code,
                                  size: 45,
                                ),
                                onPressed: () {
                                  addCodeCorrection();
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    margin: const EdgeInsets.fromLTRB(10, 10, 20, 20),
                    child: CustomButton(
                      width: double.infinity,
                      height: 0,
                      buttonColor: primaryColor,
                      padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
                      buttonText: "Examen opslaan",
                      fontSize: 35,
                      borderRadius: 25,
                      icon: const Icon(
                        Icons.save,
                        size: 45,
                      ),
                      onPressed: () {
                        saveExam();
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionsColumn(int i) {
    return Container(
      height: 75,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              width: double.infinity,
              height: 75,
              buttonColor: buttonColor,
              onPressed: () {
                AdminStart.selectedQuestion = AdminStart.exam.questions![i];
                editQuestion();
              },
              padding: const EdgeInsets.fromLTRB(0, 10, 17, 10),
              borderRadius: 19,
              buttonText: "Vraag ${i + 1}",
              fontSize: 30,
            ),
          ),
          Container(
            width: 80,
            height: double.infinity,
            margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: CustomButton(
              width: double.infinity,
              height: 75,
              buttonColor: buttonColor,
              onPressed: () {
                removeQuestion(i);
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
    );
  }
}
