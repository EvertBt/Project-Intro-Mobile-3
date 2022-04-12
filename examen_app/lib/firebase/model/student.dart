import 'package:examen_app/firebase/model/exam.dart';

class Student {
  Student({this.studentNr = "", this.exam, this.leftAppCount = 0});

  String studentNr;
  int leftAppCount;
  Exam? exam;
  //location
}
