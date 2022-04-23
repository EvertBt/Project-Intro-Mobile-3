import 'package:examen_app/config/constants.dart';
import 'package:examen_app/firebase/model/codecorrectionquestion.dart';
import 'package:flutter/material.dart';
import 'package:code_editor/code_editor.dart';
import 'package:dart_style/dart_style.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/a11y-light.dart';

Widget codeCorrectionQuestion(
  BuildContext context,
  CodeCorrectionQuestion question,
  EditorModel model,
) {
  if (model.allFiles[0].code == "") {
    model.allFiles[0].code = formatCode(question.question);
  }

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
  if (controller.text == "") {
    controller.text = formatCode(question.question);
  }
  return Container(
      margin: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        color: buttonColor,
      ),
      child: Container(
          margin: const EdgeInsets.all(3),
          padding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            children: [
              TextField(
                controller: controller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (value) => {question.answer = value},
                style: const TextStyle(fontSize: 25),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "vul hier je antwoord in"),
                cursorColor: buttonColor,
              ),
              Expanded(child: Container()),
              Container(
                width: 210.0,
                height: 50.0,
                padding: const EdgeInsets.only(right: 0),
                child: ElevatedButton(
                    onPressed: () {
                      controller.value = controller.value
                          .copyWith(text: formatCode(controller.text));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: buttonColor,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      padding: const EdgeInsets.fromLTRB(8, 8, 15, 8),
                      elevation: 5,
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: const Text(
                            'Formatteer',
                            style: TextStyle(fontSize: 25.0),
                          ),
                        ),
                        Expanded(child: Container()),
                        const Icon(
                          Icons.format_indent_increase_rounded,
                          size: 35,
                        )
                      ],
                    )),
              )
            ],
          )));
}

String formatCode(String code) {
  final formatter = DartFormatter(fixes: [StyleFix.functionTypedefs]);
  try {
    return formatter.format(code);
  } on FormatterException catch (ex) {
    return code;
  }
}
