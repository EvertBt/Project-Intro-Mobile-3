import 'package:examen_app/views/admin/exam%20views/admin_exam_codecorrection.dart';
import 'package:examen_app/views/admin/exam%20views/admin_exam_home.dart';
import 'package:examen_app/views/admin/exam%20views/admin_exam_multiplechoice.dart';
import 'package:examen_app/views/admin/exam%20views/admin_exam_openended.dart';
import 'package:flutter/material.dart';

class AdminExam extends StatefulWidget {
  const AdminExam({Key? key}) : super(key: key);

  @override
  State<AdminExam> createState() => _AdminExam();
}

enum AdminExamState {
  home,
  codeCorrection,
  multipleChoice,
  openEnded,
}

class _AdminExam extends State<AdminExam> {
  AdminExamState state = AdminExamState.home;

  void switchState(AdminExamState newState) {
    setState(() {
      state = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case AdminExamState.home:
        return AdminExamHome(switchState: switchState);
      case AdminExamState.codeCorrection:
        return AdminExamCodeCorrection(switchState: switchState);
      case AdminExamState.multipleChoice:
        return AdminExamMultipleChoice(switchState: switchState);
      case AdminExamState.openEnded:
        return AdminExamOpenEnded(switchState: switchState);
    }
  }
}
