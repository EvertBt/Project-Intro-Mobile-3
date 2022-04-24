import 'package:examen_app/views/admin/admin_exam.dart';
import 'package:flutter/material.dart';

class AdminExamHome extends StatefulWidget {
  const AdminExamHome({required this.switchState, Key? key}) : super(key: key);

  final void Function(AdminExamState) switchState;

  @override
  State<AdminExamHome> createState() => _AdminExamHome();
}

class _AdminExamHome extends State<AdminExamHome> {
  @override
  Widget build(BuildContext context) {
    return const Text("Exam home");
  }
}
