import 'package:examen_app/firebase/model/question.dart';

class Exam {
  Exam(this.duration, this.questions);

  Duration duration;
  List<Question> questions;
}
