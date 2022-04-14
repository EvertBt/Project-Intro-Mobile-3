// ignore_for_file: overridden_fields

import 'package:examen_app/firebase/model/question.dart';

class CodeCorrectionQuestion extends Question {
  CodeCorrectionQuestion(
      {this.question = '',
      this.score = 0,
      this.maxScore = 1,
      this.type = 'codecorrection',
      this.answer = ''});

  @override
  String answer;

  @override
  String question;

  @override
  String type;

  @override
  int score;

  @override
  int maxScore;
}
