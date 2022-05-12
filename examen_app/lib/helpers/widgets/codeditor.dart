import 'package:examen_app/config/constants.dart';
import 'package:examen_app/firebase/model/codecorrectionquestion.dart';
import 'package:examen_app/helpers/formatter.dart';
import 'package:examen_app/helpers/widgets/button.dart';
import 'package:flutter/material.dart';

class CodeEditor extends StatefulWidget {
  const CodeEditor({
    required this.question,
    required this.controller,
    this.isExam = true,
    Key? key,
  }) : super(key: key);

  final CodeCorrectionQuestion question;
  final TextEditingController controller;
  final bool isExam;

  @override
  State<CodeEditor> createState() => _CodeEditor();
}

class _CodeEditor extends State<CodeEditor> {
  @override
  Widget build(BuildContext context) {
    if (widget.controller.text == "") {
      widget.controller.text = formatCode(widget.question.question);
    }
    void enterText(String text, {int offset = 0}) {
      String t = widget.controller.text;
      TextSelection textSelection = widget.controller.selection;
      String newText =
          t.replaceRange(textSelection.start, textSelection.end, text);
      final textLength = text.length;
      widget.controller.text = newText;
      widget.controller.selection = textSelection.copyWith(
        baseOffset: textSelection.start + textLength + offset,
        extentOffset: textSelection.start + textLength + offset,
      );
    }

    return Column(
      children: [
        Expanded(
            child: TextField(
          controller: widget.controller,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          onChanged: (value) => {widget.question.answer = value},
          style: const TextStyle(fontSize: 25),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "vul hier je antwoord in",
          ),
          cursorColor: buttonColor,
        )),
        widget.isExam
            ? Row(
                children: [
                  CustomButton(
                    margin: const EdgeInsets.only(right: 5),
                    width: 50,
                    height: 50,
                    buttonColor: buttonColor,
                    onPressed: () {
                      enterText("  ");
                    },
                    icon: const Icon(
                      Icons.format_indent_increase_rounded,
                      size: 35,
                    ),
                  ),
                  CustomButton(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    width: 50,
                    height: 50,
                    buttonColor: buttonColor,
                    onPressed: () {
                      enterText("{}", offset: -1);
                    },
                    buttonText: " { }",
                    fontSize: 25,
                  ),
                  CustomButton(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    padding: const EdgeInsets.only(left: 15),
                    width: 50,
                    height: 50,
                    buttonColor: buttonColor,
                    onPressed: () {
                      enterText("[]", offset: -1);
                    },
                    buttonText: "[ ]",
                    fontSize: 25,
                  ),
                  CustomButton(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    width: 50,
                    height: 50,
                    buttonColor: buttonColor,
                    onPressed: () {
                      enterText("()", offset: -1);
                    },
                    buttonText: " ( )",
                    fontSize: 25,
                  ),
                  CustomButton(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    width: 50,
                    height: 50,
                    buttonColor: buttonColor,
                    onPressed: () {
                      enterText("<>", offset: -1);
                    },
                    icon: const Icon(
                      Icons.code_rounded,
                      size: 35,
                    ),
                  ),
                  CustomButton(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    width: 50,
                    height: 50,
                    buttonColor: buttonColor,
                    buttonText: " =",
                    fontSize: 30,
                    padding: const EdgeInsets.fromLTRB(9, 0, 0, 3),
                    onPressed: () {
                      enterText("=");
                    },
                  ),
                  CustomButton(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    width: 50,
                    height: 50,
                    buttonColor: buttonColor,
                    buttonText: "  ;",
                    fontSize: 30,
                    padding: const EdgeInsets.fromLTRB(7, 0, 0, 6),
                    onPressed: () {
                      enterText(";");
                    },
                  ),
                  Expanded(child: Container()),
                  CustomButton(
                    width: 210,
                    height: 50,
                    buttonColor: buttonColor,
                    buttonText: "Formatteer",
                    onPressed: () {
                      widget.controller.value = widget.controller.value
                          .copyWith(text: formatCode(widget.controller.text));
                    },
                    icon: const Icon(
                      Icons.format_align_right,
                      size: 35,
                    ),
                  ),
                ],
              )
            : Container()
      ],
    );
  }
}
