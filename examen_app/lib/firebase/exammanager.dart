import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examen_app/firebase/model/codecorrectionquestion.dart';
import 'package:examen_app/firebase/model/exam.dart';
import 'package:examen_app/firebase/model/multiplechoicequestion.dart';
import 'package:examen_app/firebase/model/question.dart';
import 'package:examen_app/firebase/model/student.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

class ExamManager {
  static Future<void> _initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Future<void> addNewExam(List<Student> students, Exam exam) async {
    await _initialize();

    //delete all old students from firestore
    var snapshot =
        await FirebaseFirestore.instance.collection('students').get();
    for (var document in snapshot.docs) {
      await document.reference.delete();
    }

    //add new exam
    await _addExam(exam);

    //add all students from list with new exam
    for (Student student in students) {
      await FirebaseFirestore.instance
          .collection('students')
          .doc(student.studentNr)
          .set({
        'leftAppCount': student.leftAppCount,
        'name': student.name,
        'studentNr': student.studentNr,
        'location': student.location,
        'exam': <String, dynamic>{
          'duration': exam.duration.inSeconds,
          'questions': _buildQuestionsMap(exam, forStudent: true)
        }
      });
    }
  }

  static Future<Exam> getExam() async {
    await _initialize();
    Exam exam = Exam();
    await FirebaseFirestore.instance
        .doc('exams/exam')
        .get()
        .then((value) => {exam = _buildExam(value.data()!)});
    return exam;
  }

  // static Future<Exam> getExam() async {
  //   await _initialize();

  //   var snapshot = await FirebaseFirestore.instance.doc('exams/exam').get();
  //   Exam exam = Exam(
  //       title: snapshot.data()!['title'].toString(),
  //       duration: Duration(
  //           seconds: int.parse(snapshot.data()!['duration'].toString())),
  //       questions: _buildQuestionList(snapshot.data()!['questions']));

  //   return exam;
  // }

  // static Future<Exam> getExamFromStudent(Student student) async {
  //   await _initialize();

  //   var snapshot = await FirebaseFirestore.instance
  //       .doc('students/${student.studentNr}')
  //       .get();
  //   Map<String, dynamic> _exam = snapshot.data()!['exam'];

  //   Exam exam = Exam(
  //       title: _exam['title'].toString(),
  //       duration: Duration(seconds: int.parse(_exam['duration'].toString())),
  //       questions: _buildQuestionList(_exam['questions']));

  //   return exam;
  // }

  static Future<void> pushExamToStudent(Exam exam, Student student) async {
    await _initialize();

    await FirebaseFirestore.instance
        .doc('students/${student.studentNr}')
        .update({
      'location': student.location,
      'leftAppCount': student.leftAppCount,
      'exam': <String, dynamic>{
        'title': exam.title,
        'duration': exam.duration.inSeconds,
        'questions': _buildQuestionsMap(exam)
      }
    });
  }

  static Future<List<Student>> getStudents() async {
    await _initialize();

    List<Student> students = [];
    await FirebaseFirestore.instance
        .collection('students')
        .get()
        .then((value) => {
              for (var student in value.docs)
                {
                  students.add(Student(
                      name: student['name'],
                      studentNr: student['studentNr'],
                      location: student['location'],
                      leftAppCount: student['leftAppCount'],
                      exam: _buildExam(student['exam'])))
                }
            });

    return students;
  }

  static Future<void> _addExam(Exam exam) async {
    await FirebaseFirestore.instance.collection('exams').doc('exam').set({
      'duration': exam.duration.inSeconds,
      'questions': _buildQuestionsMap(exam)
    });
  }

  static Exam _buildExam(Map<String, dynamic> _exam) {
    Exam exam = Exam(
        title: _exam['title'].toString(),
        duration: Duration(seconds: int.parse(_exam['duration'].toString())),
        questions: _buildQuestionList(_exam['questions']));

    return exam;
  }

  static List<Question> _buildQuestionList(Map<String, dynamic> questions) {
    List<Question> _questions = [];
    questions.forEach((key, value) {
      if (value['type'] == 'open') {
        _questions.add(Question(
            maxScore: value['maxscore'],
            score: value['score'],
            question: value['question'],
            answer: value['answer']));
      } else if (value['type'] == "multiplechoice") {
        _questions.add(
          MultipleChoiceQuestion(
              options: _buildOptionList(value['options']),
              maxScore: value['maxscore'],
              score: value['score'],
              question: value['question'],
              answer: value['answer']),
        );
      } else if (value['type'] == 'codecorrection') {
        _questions.add(CodeCorrectionQuestion(
            maxScore: value['maxscore'],
            score: value['score'],
            question: value['question'],
            answer: value['answer']));
      }
    });
    return _questions;
  }

  static List<String> _buildOptionList(Map<String, dynamic> options) {
    List<String> _options = [];
    options.forEach((key, value) {
      _options.add(value);
    });
    return _options;
  }

  static Map<String, dynamic> _buildQuestionsMap(Exam exam,
      {bool forStudent = false}) {
    Map<String, dynamic> questions = {};
    for (Question question in exam.questions!) {
      if (question is MultipleChoiceQuestion) {
        questions.addEntries({
          '${exam.questions!.indexOf(question)}': {
            'type': 'multiplechoice',
            'question': question.question,
            'answer': forStudent ? '' : question.answer,
            'maxscore': question.maxScore,
            'score': question.score,
            'options': _buildOptionsMap(question)
          }
        }.entries);
      } else if (question is CodeCorrectionQuestion) {
        questions.addEntries({
          '${exam.questions!.indexOf(question)}': {
            'type': 'codecorrection',
            'question': question.question,
            'answer': forStudent ? '' : question.answer,
            'maxscore': question.maxScore,
            'score': question.score,
          }
        }.entries);
      } else {
        questions.addEntries({
          '${exam.questions!.indexOf(question)}': {
            'type': 'open',
            'question': question.question,
            'answer': forStudent ? '' : question.answer,
            'maxscore': question.maxScore,
            'score': question.score,
          }
        }.entries);
      }
    }
    return questions;
  }

  static Map<String, dynamic> _buildOptionsMap(
      MultipleChoiceQuestion question) {
    Map<String, dynamic> options = {};
    if (question.options != null) {
      for (String? option in question.options!) {
        options.addEntries({
          '${question.options!.indexOf(option!)}': option,
        }.entries);
      }
      return options;
    } else {
      return {};
    }
  }
}
