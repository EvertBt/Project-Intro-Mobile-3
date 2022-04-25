import 'package:examen_app/firebase/model/exam.dart';

class Student {
  Student(
      {this.name = "",
      this.studentNr = "",
      this.location = "",
      this.exam,
      this.leftAppCount = 0});

  String name;
  String studentNr;
  String location;
  int leftAppCount;
  Exam? exam;
}
