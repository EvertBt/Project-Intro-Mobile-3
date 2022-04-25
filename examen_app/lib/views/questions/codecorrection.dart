import 'package:examen_app/config/constants.dart';
import 'package:examen_app/firebase/model/codecorrectionquestion.dart';
import 'package:examen_app/helpers/formatter.dart';
import 'package:examen_app/helpers/widgets/codeditor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/a11y-light.dart';

Widget codeCorrectionQuestion(
  BuildContext context,
  CodeCorrectionQuestion question,
) {
  return Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: const Text(
          "Pas de volgende code aan zodat ze correct werkt",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        margin: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        alignment: Alignment.centerLeft,
        child: HighlightView(
          formatCode(question.question),
          language: "C#",
          theme: a11yLightTheme,
          textStyle: const TextStyle(fontSize: 20),
        ),
      )
    ],
  );
}

Widget codeCorrectionAnswer(BuildContext context,
    CodeCorrectionQuestion question, TextEditingController controller) {
  return Container(
    margin: const EdgeInsets.all(30),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(23),
      color: buttonColor,
    ),
    child: Container(
      margin: const EdgeInsets.all(3),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: CodeEditor(
        controller: controller,
        question: question,
      ),
    ),
  );
}
