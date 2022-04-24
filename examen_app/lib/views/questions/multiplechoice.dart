import 'package:examen_app/config/constants.dart';
import 'package:examen_app/firebase/model/multiplechoicequestion.dart';
import 'package:examen_app/firebase/model/question.dart';
import 'package:flutter/material.dart';

Widget multipleChoiceQuestion(
    BuildContext context, MultipleChoiceQuestion question) {
  return Container(
    margin: const EdgeInsets.fromLTRB(30, 40, 30, 30),
    child: TextField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      readOnly: true,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: question.question,
          hintStyle: const TextStyle(
            fontSize: 30,
            color: Colors.black,
          )),
    ),
  );
}

class MultipleChoiceAnswer extends StatefulWidget {
  const MultipleChoiceAnswer({required this.question, Key? key})
      : super(key: key);

  final MultipleChoiceQuestion question;

  @override
  State<MultipleChoiceAnswer> createState() => _MultipleChoiceAnswer();
}

class _MultipleChoiceAnswer extends State<MultipleChoiceAnswer> {
  List<Widget> _radioButtonList(
      MultipleChoiceQuestion question, String? selectedAnswer) {
    List<Widget> buttons = [];

    for (String option in question.options!) {
      buttons.add(TextButton(
          style: TextButton.styleFrom(primary: Colors.grey),
          onPressed: () {},
          child: RadioListTile<String>(
            title: Text(
              option,
              style: const TextStyle(fontSize: 25),
            ),
            value: option,
            groupValue: selectedAnswer,
            activeColor: buttonColor,
            onChanged: (value) {
              setState(() {
                selectedAnswer = value;
                question.answer = value!;
              });
            },
          )));
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    String? selectedAnswer = widget.question.answer;

    return Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          children: _radioButtonList(widget.question, selectedAnswer),
        ));
  }
}
