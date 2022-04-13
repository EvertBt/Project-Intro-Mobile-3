import 'package:examen_app/firebase/model/question.dart';

class CodeCorrectionQuestion implements Question {
  CodeCorrectionQuestion(
      {this.question = '',
      this.score = 0,
      this.type = 'codecorrection',
      this.answer = ''});

  @override
  String answer;

  @override
  String? question;

  @override
  String type;

  @override
  int score;
}
