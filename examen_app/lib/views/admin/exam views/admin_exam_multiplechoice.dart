import 'package:examen_app/views/admin/admin_exam.dart';
import 'package:flutter/material.dart';

class AdminExamMultipleChoice extends StatefulWidget {
  const AdminExamMultipleChoice({required this.switchState, Key? key})
      : super(key: key);

  final void Function(AdminExamState) switchState;

  @override
  State<AdminExamMultipleChoice> createState() => _AdminExamMultipleChoice();
}

class _AdminExamMultipleChoice extends State<AdminExamMultipleChoice> {
  @override
  Widget build(BuildContext context) {
    return const Text("multiple choice");
  }
}
