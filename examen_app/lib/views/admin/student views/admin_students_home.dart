import 'package:examen_app/firebase/exammanager.dart';
import 'package:examen_app/firebase/model/student.dart';
import 'package:examen_app/views/admin/admin_start.dart';
import 'package:examen_app/views/admin/admin_students.dart';
import 'package:flutter/material.dart';

class AdminStudentsHome extends StatefulWidget {
  const AdminStudentsHome({required this.switchState, Key? key})
      : super(key: key);

  final void Function(AdminStudentState) switchState;

  @override
  State<AdminStudentsHome> createState() => _AdminStudentsHome();
}

class _AdminStudentsHome extends State<AdminStudentsHome> {
  void loadStudents() async {
    AdminStart.students = await ExamManager.getStudents();
  }

  @override
  void initState() {
    if (AdminStart.students.isEmpty) {
      loadStudents();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Text("Student home");
  }
}
