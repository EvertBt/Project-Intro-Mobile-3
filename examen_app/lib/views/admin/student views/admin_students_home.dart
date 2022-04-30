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
  final TextEditingController _addStudentController = TextEditingController();

  bool editingStudents = false;

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

  void _editStudents() {
    editingStudents = true;
    setState(() {});
  }

  void _addStudent() {
    // AdminStart.students.add( snr + naam? );
  }

  void _saveStudents() {
    editingStudents = false;
    setState(() {});
  }

  void _clearSearchTextField() {
    _controller.clear();
    _searchStudent("");
  }

  void _clearStudentTextField() {
    _addStudentController.clear();
    setState(() {});
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: TextField(
                                controller: _controller,
                                onChanged: (value) => {_searchStudent(value)},
                                cursorColor: buttonColor,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(12, 24, 12, 20),
                                  labelText: "zoek op naam of studentnummer",
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
                                          onPressed: _clearSearchTextField,
                                        ),
                                ),
                              ))),
                    ),
                  ],
                ),
              ),
              editingStudents
                  ? Container(
                      width: double.infinity,
                      height: 75.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: buttonColor,
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
                            elevation: 5,
                          ),
                          child: Row(
                            children: [
                              Container(
                                  height: 50,
                                  width: 500,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: TextField(
                                    controller: _addStudentController,
                                    style: const TextStyle(fontSize: 23),
                                    textAlignVertical: TextAlignVertical.center,
                                    onChanged: (value) => {_editStudents()},
                                    cursorColor: buttonColor,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          12, 24, 12, 20),
                                      labelStyle:
                                          const TextStyle(color: Colors.black),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: buttonColor),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.black)),
                                      suffixIcon: _addStudentController
                                              .text.isEmpty
                                          ? null
                                          : IconButton(
                                              icon: const Icon(
                                                Icons.clear,
                                                color: buttonColor,
                                              ),
                                              onPressed: _clearStudentTextField,
                                            ),
                                    ),
                                  ))
                            ],
                          )),
                    )
                  : Container(),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: ListView.builder(
                    itemCount: AdminStart.searchStudents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildRow(index);
                    }),
              )),
              Row(
                children: [
                  editingStudents
                      ? CustomButton(
                          onPressed: () {},
                          width: 80,
                          height: 80,
                          borderRadius: 40,
                          buttonColor: buttonColor,
                          padding: const EdgeInsets.fromLTRB(10, 10, 16, 12),
                          margin: const EdgeInsets.all(20),
                          icon: const Icon(
                            Icons.upload_file_outlined,
                            size: 45,
                          ),
                        )
                      : Container(),
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
                          margin: const EdgeInsets.all(20),
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
                          margin: const EdgeInsets.all(20),
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
