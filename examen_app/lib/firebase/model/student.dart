import 'package:examen_app/firebase/model/exam.dart';

class Student {
  Student(
      {this.studentNr = "",
      this.location = "",
      this.exam,
      this.leftAppCount = 0});

  String studentNr;
  String location;
  int leftAppCount;
  Exam? exam;
}
