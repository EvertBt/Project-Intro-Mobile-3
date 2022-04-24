import 'package:examen_app/firebase/model/student.dart';
import 'package:examen_app/views/admin/admin_students.dart';
import 'package:flutter/material.dart';

class AdminStudentAnswer extends StatefulWidget {
  const AdminStudentAnswer(
      {required this.student, required this.switchState, Key? key})
      : super(key: key);

  final void Function(AdminStudentState) switchState;
  final Student? student;

  @override
  State<AdminStudentAnswer> createState() => _AdminStudentAnswer();
}

class _AdminStudentAnswer extends State<AdminStudentAnswer> {
  @override
  Widget build(BuildContext context) {
    return const Text("Student answer");
  }
}
