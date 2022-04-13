import 'package:examen_app/firebase/model/question.dart';

class MultipleChoiceQuestion implements Question {
  MultipleChoiceQuestion(
      {this.question = '',
      this.options,
      this.type = 'multiplechoice',
      this.answer = ''});

  @override
  String answer;

  @override
  String? question;

  @override
  String type;

  List<String>? options;
}
