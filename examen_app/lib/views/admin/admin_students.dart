import 'package:examen_app/firebase/model/question.dart';
import 'package:examen_app/views/admin/student%20views/admin_students_home.dart';
import 'package:examen_app/views/admin/student%20views/admin_students_student_answer.dart';
import 'package:examen_app/views/admin/student%20views/admin_students_student_details.dart';
import 'package:flutter/material.dart';

class AdminStudents extends StatefulWidget {
  const AdminStudents({Key? key}) : super(key: key);

  @override
  State<AdminStudents> createState() => _AdminStudents();
}

enum AdminStudentState { home, studentDetails, studentAnswer }

class _AdminStudents extends State<AdminStudents> {
  AdminStudentState state = AdminStudentState.home;

  Question? question;

  void switchState(AdminStudentState newState) {
    setState(() {
      state = newState;
    });
  }

  Widget _build(BuildContext context) {
    switch (state) {
      case AdminStudentState.home:
        return AdminStudentsHome(switchState: switchState);
      case AdminStudentState.studentDetails:
        return AdminStudentDetails(switchState: switchState);
      case AdminStudentState.studentAnswer:
        return AdminStudentAnswer(switchState: switchState);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }
}
