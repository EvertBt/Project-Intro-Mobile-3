import 'package:examen_app/firebase/model/student.dart';
import 'package:examen_app/views/admin/admin_students.dart';
import 'package:flutter/material.dart';

class AdminStudentDetails extends StatefulWidget {
  const AdminStudentDetails({
    required this.student,
    required this.switchState,
    Key? key,
  }) : super(key: key);

  final void Function(AdminStudentState) switchState;
  final Student? student;

  @override
  State<AdminStudentDetails> createState() => _AdminStudentDetails();
}

class _AdminStudentDetails extends State<AdminStudentDetails> {
  @override
  Widget build(BuildContext context) {
    return const Text("Student details");
  }
}
