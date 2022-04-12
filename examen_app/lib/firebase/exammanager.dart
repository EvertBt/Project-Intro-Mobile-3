import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examen_app/firebase/model/exam.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

class ExamManager {
  static Future<void> _initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Future<Exam> getExam() async {
    await _initialize();

    var result = await FirebaseFirestore.instance.doc('exams/exam').get();
    Exam exam = Exam(title: result.data()!['title'].toString());

    return exam;
  }
}
