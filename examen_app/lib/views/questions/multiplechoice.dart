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
            fontSize: 35,
            color: Colors.black,
          )),
    ),
  );
}

Widget multipleChoiceAnswer(
    BuildContext context, MultipleChoiceQuestion question) {
  String? selectedAnswer = "";
  if (question.answer == "") {
    selectedAnswer = question.options![0];
  }
  return Container(
    margin: const EdgeInsets.all(30),
    child: ListView.builder(
        itemCount: question.options!.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildRow(index, question, selectedAnswer);
        }),
  );
}

Widget _buildRow(
    int i, MultipleChoiceQuestion question, String? selectedAnswer) {
  return RadioListTile<String>(
    title: Text(question.options![i]),
    value: question.options![i],
    groupValue: selectedAnswer,
    onChanged: (value) {
      selectedAnswer = value;
    },
  );
}
