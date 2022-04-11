import 'package:examen_app/firebase/model/question.dart';

class MultipleChoiceQuestion implements Question {
  MultipleChoiceQuestion({this.question, this.choices, this.answer = ""});

  @override
  String answer;

  @override
  String? question;

  List<String>? choices;
}
