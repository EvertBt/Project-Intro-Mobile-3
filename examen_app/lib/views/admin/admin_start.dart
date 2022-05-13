import 'package:examen_app/firebase/model/question.dart';
import 'package:examen_app/firebase/exammanager.dart';
import 'package:examen_app/firebase/model/exam.dart';
import 'package:examen_app/firebase/model/student.dart';
import 'package:examen_app/views/admin/admin_exam.dart';
import 'package:examen_app/views/admin/admin_students.dart';
import 'package:examen_app/views/admin/changepassword.dart';
import 'package:examen_app/config/constants.dart';
import 'package:flutter/material.dart';

class AdminStart extends StatefulWidget {
  const AdminStart({Key? key}) : super(key: key);

  static Student? selectedStudent;
  static Question? selectedQuestion;
  static List<Student> students = [];
  static Exam exam = Exam();
  static List<Student> searchStudents = [];

  @override
  State<AdminStart> createState() => _AdminStart();
}

class _AdminStart extends State<AdminStart> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    AdminStudents(),
    AdminExam(),
    ChangePassword()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void loadStudents() async {
    AdminStart.students = await ExamManager.getStudents();
  }

  void loadExam() async {
    AdminStart.exam = await ExamManager.getExam();
  }

  @override
  void initState() {
    super.initState();

    if (AdminStart.students.isEmpty) {
      loadStudents();
    }
    if (AdminStart.exam.questions == null) {
      loadExam();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(homeRoute, (route) => false);
        return false;
      },
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100.0,
              height: 70.0,
              padding: const EdgeInsets.only(left: 15.0),
              decoration: const BoxDecoration(
                color: primaryColor,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 13.0),
                child: const Image(
                  image: AssetImage('assets/logosmall.png'),
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 70,
                child: BottomNavigationBar(
                  elevation: 0,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.people,
                        size: 40,
                      ),
                      label: 'Studenten',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.book,
                        size: 40,
                      ),
                      label: 'Examen',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.lock,
                        size: 40,
                      ),
                      label: 'Wachtwoord wijzigen',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  backgroundColor: primaryColor,
                  selectedItemColor: Colors.white,
                  onTap: _onItemTapped,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: primaryColor,
              ),
              height: 70.0,
              width: 100.0,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(homeRoute, (route) => false);
                },
                style: TextButton.styleFrom(primary: Colors.white),
                child: const Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 45,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
