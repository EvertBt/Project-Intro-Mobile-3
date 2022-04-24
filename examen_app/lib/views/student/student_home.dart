import 'package:examen_app/config/constants.dart';
import 'package:examen_app/firebase/exammanager.dart';
import 'package:examen_app/firebase/model/student.dart';
import 'package:examen_app/helpers/locationrequester.dart';
import 'package:flutter/material.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHome();
}

class _StudentHome extends State<StudentHome> {
  final List<Student> _students = <Student>[];
  final List<Student> _searchStudents = <Student>[];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    await ExamManager.getStudents().then((value) => {
          _students.addAll(value),
          setState(() {
            _searchStudents.addAll(_students);
          })
        });
  }

  void _searchStudent(String searchText) {
    setState(() {
      _searchStudents.clear();
      for (Student student in _students) {
        if (student.studentNr.contains(searchText)) {
          _searchStudents.add(student);
        }
      }
      if (_searchStudents.isEmpty) {
        _searchStudents.addAll(_students);
      }
    });
  }

  void _clearTextField() {
    _controller.clear();
    _searchStudent("");
  }

  Widget _buildRow(int i) {
    return Container(
      width: double.infinity,
      height: 75.0,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: ElevatedButton(
          onPressed: () async {
            Navigator.pushNamed(context, studentExamRoute,
                arguments: _searchStudents[i]);
          },
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
            onPrimary: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.all(8.0),
            elevation: 5,
          ),
          child: Text(
            _searchStudents[i].studentNr,
            style: const TextStyle(fontSize: 30.0),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
              child: Text(
            'Studenten',
            style: TextStyle(fontSize: 30.0),
          )),
          backgroundColor: primaryColor,
        ),
        body: Center(
          child: Container(
            margin:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            width: 700.0,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.grey)],
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, blurRadius: 5)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                            height: 70,
                            child: Container(
                                width: 600,
                                height: 90,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: TextField(
                                  controller: _controller,
                                  onChanged: (value) => {_searchStudent(value)},
                                  cursorColor: buttonColor,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        12, 24, 12, 20),
                                    labelText: "zoek op studentnummer",
                                    errorText: "",
                                    labelStyle:
                                        const TextStyle(color: Colors.black),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: buttonColor),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.black)),
                                    suffixIcon: _controller.text.isEmpty
                                        ? null
                                        : IconButton(
                                            icon: const Icon(
                                              Icons.clear,
                                              color: buttonColor,
                                            ),
                                            onPressed: _clearTextField,
                                          ),
                                  ),
                                ))),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ListView.builder(
                      itemCount: _searchStudents.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildRow(index);
                      }),
                ))
              ],
            ),
          ),
        ),
        bottomNavigationBar: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 100.0,
                height: 56.0,
                padding: const EdgeInsets.only(left: 10.0),
                decoration: const BoxDecoration(
                  color: primaryColor,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 13.0),
                  child: const Image(
                    image: AssetImage('assets/logosmall.png'),
                    filterQuality: FilterQuality.high,
                  ),
                )),
            Expanded(
              child: Container(
                height: 56.0,
                decoration: const BoxDecoration(color: primaryColor),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: primaryColor,
              ),
              height: 56.0,
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
                    size: 35,
                  )),
            )
          ],
        ));
  }
}
