import 'package:examen_app/firebase/model/question.dart';
import 'package:examen_app/firebase/model/student.dart';
import 'package:examen_app/views/admin/student%20views/admin_students_add_student.dart';
import 'package:examen_app/views/admin/student%20views/admin_students_home.dart';
import 'package:examen_app/views/admin/student%20views/admin_students_student_answer.dart';
import 'package:examen_app/views/admin/student%20views/admin_students_student_details.dart';
import 'package:flutter/material.dart';

class AdminStudents extends StatefulWidget {
  const AdminStudents({Key? key}) : super(key: key);

  @override
  State<AdminStudents> createState() => _AdminStudents();
}

enum AdminStudentState { home, addStudent, studentDetails, studentAnswer }

class _AdminStudents extends State<AdminStudents> {
  AdminStudentState state = AdminStudentState.home;

  Student? student;
  List<Student>? students;
  Question? question;

  void switchState(AdminStudentState newState,
      {Student? student_, List<Student>? students_, Question? question_}) {
    setState(() {
      students = students_;
      student = student_;
      state = newState;
      question = question_;
    });
  }

  Widget _build(BuildContext context) {
    switch (state) {
      case AdminStudentState.home:
        return AdminStudentsHome(switchState: switchState);
      case AdminStudentState.addStudent:
        return AdminStudentsAddStudent(switchState: switchState);
      case AdminStudentState.studentDetails:
        return AdminStudentDetails(student: student, switchState: switchState);
      case AdminStudentState.studentAnswer:
        return AdminStudentAnswer(
            student: student, switchState: switchState, question: question);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }
}
