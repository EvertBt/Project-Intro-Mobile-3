import 'package:examen_app/firebase/model/question.dart';

class CodeCorrectionQuestion implements Question {
  CodeCorrectionQuestion({this.question, this.answer = ''});

  @override
  String answer;

  @override
  String? question;
}
