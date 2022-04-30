import 'package:examen_app/views/admin/admin_students.dart';
import 'package:flutter/material.dart';

class AdminStudentDetails extends StatefulWidget {
  const AdminStudentDetails({
    required this.switchState,
    Key? key,
  }) : super(key: key);

  final void Function(AdminStudentState) switchState;

  @override
  State<AdminStudentDetails> createState() => _AdminStudentDetails();
}

class _AdminStudentDetails extends State<AdminStudentDetails> {
  //Gebruik AdminStart.selectedStudent
  //Zet AdminStart.selectedQuestion voor je switchState naar student_answer gaat

  @override
  Widget build(BuildContext context) {
    return const Text("Student details");
  }
}
