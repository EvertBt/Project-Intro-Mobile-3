import 'package:examen_app/views/admin/admin_exam.dart';
import 'package:flutter/material.dart';

class AdminExamOpenEnded extends StatefulWidget {
  const AdminExamOpenEnded({required this.switchState, Key? key})
      : super(key: key);

  final void Function(AdminExamState) switchState;

  @override
  State<AdminExamOpenEnded> createState() => _AdminExamOpenEnded();
}

class _AdminExamOpenEnded extends State<AdminExamOpenEnded> {
  @override
  Widget build(BuildContext context) {
    return const Text("open ended");
  }
}
