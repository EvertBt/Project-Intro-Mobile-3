import 'package:examen_app/config/constants.dart';
import 'package:examen_app/firebase/model/student.dart';
import 'package:examen_app/views/admin_start.dart';
import 'package:examen_app/views/changepassword.dart';
import 'package:examen_app/views/home.dart';
import 'package:examen_app/views/login.dart';
import 'package:examen_app/views/student_exam.dart';
import 'package:examen_app/views/student_home.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const Home());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const Login());
      case studentHomeRoute:
        return MaterialPageRoute(builder: (_) => const StudentHome());
      case adminStartRoute:
        return MaterialPageRoute(builder: (_) => const AdminStart());
      case changePasswordRoute:
        return MaterialPageRoute(builder: (_) => const ChangePassword());
      case studentExamRoute:
        Student student = settings.arguments as Student;
        return MaterialPageRoute(builder: (_) => StudentExam(student: student));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
