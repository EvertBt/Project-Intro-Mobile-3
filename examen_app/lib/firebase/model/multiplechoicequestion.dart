import 'package:examen_app/firebase/model/question.dart';

class MultipleChoiceQuestion implements Question {
  MultipleChoiceQuestion(
      {this.question = '',
      this.score = 0,
      this.maxScore = 1,
      this.options,
      this.type = 'multiplechoice',
      this.answer = ''});

  @override
  String answer;

  @override
  String? question;

  @override
  int score;

  @override
  String type;

  @override
  int maxScore;

  List<String>? options;
}
