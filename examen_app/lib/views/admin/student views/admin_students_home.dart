import 'package:examen_app/config/constants.dart';
import 'package:examen_app/firebase/model/student.dart';
import 'package:examen_app/helpers/widgets/button.dart';
import 'package:examen_app/views/admin/admin_start.dart';
import 'package:examen_app/views/admin/admin_students.dart';
import 'package:flutter/material.dart';

class AdminStudentsHome extends StatefulWidget {
  const AdminStudentsHome({required this.switchState, Key? key})
      : super(key: key);

  final void Function(AdminStudentState) switchState;

  @override
  State<AdminStudentsHome> createState() => _AdminStudentsHome();
}

class _AdminStudentsHome extends State<AdminStudentsHome> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _csvTextController = TextEditingController();

  bool editingStudents = false;
  bool wrongFormat = false;

  void _searchStudent(String searchText) {
    setState(() {
      AdminStart.searchStudents.clear();
      for (Student student in AdminStart.students) {
        if (student.studentNr
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            student.name.toLowerCase().contains(searchText.toLowerCase())) {
          AdminStart.searchStudents.add(student);
        }
      }
    });
  }

  bool convertCSVToStudent() {
    List<Student> studentsToKeep = [];
    List<Student> newStudents = [];
    if (_csvTextController.text != '') {
      try {
        List<String> items = _csvTextController.text.split(';');
        for (String item in items) {
          if (item != '') {
            List<String> student = _cleanList(item.split(' '));

            if (student.length < 3 ||
                student[student.length - 1][0].toLowerCase() != 's' ||
                !_isNumeric(student[student.length - 1].substring(1)) ||
                student[student.length - 1].length != 7) {
              return false;
            }

            String _name = '';
            for (String name in student) {
              if (name != student[student.length - 1]) {
                if (name == student[0]) {
                  _name += name;
                } else {
                  // ignore: unnecessary_brace_in_string_interps
                  _name += ' ${name}';
                }
              }
            }
            bool exists = false;
            Student studentToKeep = Student();
            for (Student _student in AdminStart.students) {
              if (_student.name == _name &&
                  _student.studentNr == student[student.length - 1]) {
                studentToKeep = _student;
                exists = true;
              }
            }
            if (exists) {
              studentsToKeep.add(studentToKeep);
            } else {
              newStudents.add(Student(
                name: _name,
                studentNr: student[student.length - 1],
              ));
            }
          }
        }
      } catch (_) {
        return false;
      }
    }

    AdminStart.students.clear();
    AdminStart.searchStudents.clear();

    AdminStart.students.addAll(studentsToKeep);
    AdminStart.students.addAll(newStudents);

    AdminStart.searchStudents.addAll(studentsToKeep);
    AdminStart.searchStudents.addAll(newStudents);

    return true;
  }

  List<String> _cleanList(List<String> list) {
    List<String> _list = [];
    for (String item in list) {
      if (item != ' ' && item != '') {
        _list.add(item);
      }
    }
    return _list;
  }

  bool _isNumeric(String s) {
    return int.tryParse(s) != null;
  }

  void convertStudentToCSV() {
    _csvTextController.clear();
    for (Student student in AdminStart.students) {
      _csvTextController.text += '${student.name} ${student.studentNr};';
    }
  }

  void _editStudents() {
    editingStudents = true;
    convertStudentToCSV();
    setState(() {});
  }

  void _saveStudents() {
    if (convertCSVToStudent() == false) {
      setState(() {
        wrongFormat = true;
      });
    } else {
      wrongFormat = false;
      editingStudents = false;
    }
    setState(() {});
  }

  void _clearSearchTextField() {
    _controller.clear();
    _searchStudent("");
  }

  void getStudents() async {
    if (AdminStart.searchStudents.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 10)).then((value) => {
            if (AdminStart.students.isEmpty)
              {getStudents()}
            else
              {
                for (Student student in AdminStart.students)
                  {AdminStart.searchStudents.add(student)}
              }
          });
      setState(() {});
    }
  }

  Widget _buildRow(int i) {
    return Container(
      width: double.infinity,
      height: 75.0,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: ElevatedButton(
          onPressed: () {
            AdminStart.selectedStudent = AdminStart.students[i];
            widget.switchState(AdminStudentState.studentDetails);
          },
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
            onPrimary: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.all(8.0),
            elevation: 5,
          ),
          child: Row(
            children: [
              Container(
                width: 450,
                padding: const EdgeInsets.only(left: 30, top: 12, bottom: 12),
                child: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.contain,
                    child: Text(
                      AdminStart.searchStudents[i].name,
                      style: const TextStyle(fontSize: 30.0),
                    )),
              ),
              Expanded(child: Container()),
              Container(
                padding: const EdgeInsets.only(right: 30),
                child: Text(
                  AdminStart.searchStudents[i].studentNr,
                  style: const TextStyle(fontSize: 30.0),
                ),
              ),
            ],
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    getStudents();
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
          margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          width: 700.0,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.grey)],
              borderRadius: BorderRadius.circular(25)),
          child: Column(
            children: [
              editingStudents
                  ? Container()
                  : Container(
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
                                      onChanged: (value) =>
                                          {_searchStudent(value)},
                                      cursorColor: buttonColor,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                12, 24, 12, 20),
                                        labelText:
                                            "zoek op naam of studentnummer",
                                        errorText: "",
                                        labelStyle: const TextStyle(
                                            color: Colors.black),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: buttonColor),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.black)),
                                        suffixIcon: _controller.text.isEmpty
                                            ? null
                                            : IconButton(
                                                icon: const Icon(
                                                  Icons.clear,
                                                  color: buttonColor,
                                                ),
                                                onPressed:
                                                    _clearSearchTextField,
                                              ),
                                      ),
                                    ))),
                          ),
                        ],
                      ),
                    ),
              editingStudents
                  ? Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: buttonColor, width: 3),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            controller: _csvTextController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            onChanged: (value) => {}, //on change
                            style: const TextStyle(fontSize: 21),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            cursorColor: buttonColor,
                          )),
                    )
                  : Expanded(
                      child: Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ListView.builder(
                          itemCount: AdminStart.searchStudents.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildRow(index);
                          }),
                    )),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      wrongFormat
                          ? Container(
                              margin: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                              alignment: Alignment.topLeft,
                              child: const Text(
                                "Fout invoerformaat!",
                                style:
                                    TextStyle(fontSize: 20, color: buttonColor),
                              ),
                            )
                          : Container(),
                      editingStudents
                          ? Container(
                              margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              alignment: Alignment.topLeft,
                              child: const Text(
                                "CSV formaat:  voornaam naam s-nummer",
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          : Container()
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  editingStudents
                      ? CustomButton(
                          onPressed: () {
                            _saveStudents();
                          },
                          width: 80,
                          height: 80,
                          borderRadius: 40,
                          buttonColor: buttonColor,
                          padding: const EdgeInsets.fromLTRB(10, 10, 16, 12),
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          icon: const Icon(
                            Icons.save,
                            size: 45,
                          ),
                        )
                      : CustomButton(
                          onPressed: () {
                            _editStudents();
                          },
                          width: 80,
                          height: 80,
                          borderRadius: 40,
                          buttonColor: buttonColor,
                          padding: const EdgeInsets.fromLTRB(10, 10, 15, 12),
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          icon: const Icon(
                            Icons.edit,
                            size: 45,
                          ),
                        )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
