import 'package:examen_app/views/admin/admin_exam.dart';
import 'package:flutter/material.dart';

class AdminExamCodeCorrection extends StatefulWidget {
  const AdminExamCodeCorrection({required this.switchState, Key? key})
      : super(key: key);

  final void Function(AdminExamState) switchState;

  @override
  State<AdminExamCodeCorrection> createState() => _AdminExamCodeCorrection();
}

class _AdminExamCodeCorrection extends State<AdminExamCodeCorrection> {
  @override
  Widget build(BuildContext context) {
    return const Text("code correction");
  }
}
