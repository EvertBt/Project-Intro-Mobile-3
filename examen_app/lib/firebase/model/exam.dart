import 'package:examen_app/firebase/model/question.dart';

class Exam {
  Exam({this.duration = Duration.zero, this.questions, this.title = ""});

  String title;
  Duration duration;
  List<Question>? questions;
}
