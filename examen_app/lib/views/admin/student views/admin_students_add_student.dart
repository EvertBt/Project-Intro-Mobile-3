import 'package:examen_app/firebase/model/student.dart';
import 'package:examen_app/views/admin/admin_start.dart';
import 'package:examen_app/views/admin/admin_students.dart';
import 'package:flutter/material.dart';

class AdminStudentsAddStudent extends StatefulWidget {
  const AdminStudentsAddStudent({required this.switchState, Key? key})
      : super(key: key);

  final void Function(AdminStudentState) switchState;

  @override
  State<AdminStudentsAddStudent> createState() => _AdminStudentsAddStudent();
}

class _AdminStudentsAddStudent extends State<AdminStudentsAddStudent> {
  List<Student> _students = [];

  void setStudents() {
    AdminStart.students = _students;
  }

  //to load student list, use AdminStart.students

  @override
  Widget build(BuildContext context) {
    return const Text("Add student");
  }
}
