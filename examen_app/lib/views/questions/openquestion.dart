import 'package:examen_app/config/constants.dart';
import 'package:examen_app/firebase/model/question.dart';
import 'package:flutter/material.dart';

Widget openQuestion(BuildContext context, Question question) {
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

Widget openQuestionAnswer(
    BuildContext context, Question question, TextEditingController controller) {
  if (controller.text == "!empty!") {
    controller.text = question.answer;
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
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          onChanged: (value) => question.answer = value,
          style: const TextStyle(fontSize: 25),
          decoration: const InputDecoration(
              border: InputBorder.none, hintText: "vul hier je antwoord in"),
          cursorColor: buttonColor,
        ),
      ));
}
