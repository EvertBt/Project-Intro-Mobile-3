import 'package:examen_app/config/constants.dart';
import 'package:examen_app/firebase/exammanager.dart';
import 'package:examen_app/firebase/model/student.dart';
import 'package:examen_app/helpers/widgets/button.dart';
import 'package:examen_app/views/admin/admin_start.dart';
import 'package:examen_app/views/admin/admin_students.dart';
import 'package:examen_app/views/admin/student%20views/admin_students_student_answer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart" as latLng;
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminStudentDetails extends StatefulWidget {
  const AdminStudentDetails({
    required this.switchState,
    Key? key,
  }) : super(key: key);

  final void Function(AdminStudentState) switchState;

  @override
  State<AdminStudentDetails> createState() => _AdminStudentDetails();
}

class Location {
  final String display_name;

  const Location({
    required this.display_name,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      display_name: json['display_name'],
    );
  }
}

Future<Location> fetchAlbum() async {
  final response = await http.get(Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?format=json&' +
          AdminStart.selectedStudent!.location +
          '&zoom=18&addressdetails='));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Location.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load location');
  }
}

class _AdminStudentDetails extends State<AdminStudentDetails> {
  final TextEditingController scoreController = TextEditingController();
  late Future<Location> futureLocation;
  //Gebruik AdminStart.selectedStudent
  //Zet AdminStart.selectedQuestion voor je switchState naar student_answer gaat
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    futureLocation = fetchAlbum();
  }

  double getLat() {
    String location = AdminStart.selectedStudent!.location;
    if (location != "") {
      List<String> splittedLocation = location.split('&');
      double lat = double.parse(splittedLocation[0].substring(4));
      return lat;
    } else {
      return 0;
    }
  }

  double getLng() {
    String location = AdminStart.selectedStudent!.location;
    if (location != "") {
      List<String> splittedLocation = location.split('&');
      double lng = double.parse(splittedLocation[1].substring(4));
      return lng;
    } else {
      return 0;
    }
  }

  String rightAdress(adress) {
    List<String> splittedAdress = adress.split(', ');
    String refinedAdress = splittedAdress[0] +
        "\n" +
        splittedAdress[2] +
        " " +
        splittedAdress[1] +
        ", " +
        splittedAdress[6] +
        " " +
        splittedAdress[4];
    return refinedAdress;
  }

  Widget _buildRow(int i) {
    return Container(
      width: double.infinity,
      height: 75.0,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: ElevatedButton(
          onPressed: () {
            AdminStart.selectedQuestion =
                AdminStart.selectedStudent!.exam!.questions![i];
            widget.switchState(AdminStudentState.studentAnswer);
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
                margin: const EdgeInsets.only(left: 20),
                child: Text(
                  "Vraag ${i + 1}",
                  style: const TextStyle(fontSize: 30.0),
                ),
              ),
              Expanded(child: Container()),
            ],
          )),
    );
  }

  @override
  void initState() {
    scoreController.text = AdminStart.selectedStudent!.score.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
              ),
              Expanded(child: Container()),
              Text(
                "Details van student: ${AdminStart.selectedStudent!.name}",
                style: const TextStyle(fontSize: 30),
              ),
              Expanded(child: Container()),
              Text(AdminStart.selectedStudent!.studentNr)
            ],
          ),
          backgroundColor: primaryColor,
        ),
        body: Row(
          children: [
            Expanded(
                child: Column(
              children: [
                Expanded(
                    flex: 6,
                    child: Container(
                        margin: const EdgeInsets.fromLTRB(20, 15, 10, 15),
                        width: 900.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(blurRadius: 5, color: Colors.grey)
                            ],
                            borderRadius: BorderRadius.circular(25)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: FlutterMap(
                              options: MapOptions(
                                center: latLng.LatLng(getLat(), getLng()),
                                zoom: 16,
                              ),
                              children: <Widget>[
                                TileLayerWidget(
                                    options: TileLayerOptions(
                                        urlTemplate:
                                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                        subdomains: ['a', 'b', 'c'])),
                                MarkerLayerWidget(
                                    options: MarkerLayerOptions(
                                  markers: [
                                    Marker(
                                      width: 80.0,
                                      height: 80.0,
                                      point: latLng.LatLng(getLat(), getLng()),
                                      builder: (ctx) => const Icon(
                                          Icons.location_on,
                                          color: Colors.blue,
                                          size: 50),
                                    ),
                                  ],
                                )),
                              ],
                            )))),
                Expanded(
                    flex: 1,
                    child: Container(
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 10, bottom: 15),
                        width: 900.0,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(blurRadius: 5, color: Colors.grey)
                            ],
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(left: 30),
                                child: FutureBuilder<Location>(
                                  future: futureLocation,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return FittedBox(
                                        fit: BoxFit.fill,
                                        child: Text(
                                            rightAdress(
                                                snapshot.data!.display_name),
                                            style: const TextStyle(
                                              fontSize: 25,
                                            )),
                                      );
                                    } else {
                                      return const Text(
                                        'Locatie kan niet geladen worden',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: buttonColor,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }
                                    ;
                                  },
                                )),
                            Expanded(child: Container()),
                          ],
                        )))
              ],
            )),
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 15, 20, 15),
                    width: 900.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(blurRadius: 5, color: Colors.grey)
                        ],
                        borderRadius: BorderRadius.circular(25)),
                    child: Container(
                        margin: const EdgeInsets.only(
                            left: 50, bottom: 20, top: 20),
                        child: Column(children: [
                          Row(children: [
                            const Text(
                              "Punten",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Expanded(child: Container()),
                            Container(
                                width: 60,
                                margin: const EdgeInsets.only(right: 5),
                                child: TextField(
                                  controller: scoreController,
                                  onChanged: (value) => {
                                    AdminStart.selectedStudent!.score =
                                        int.parse(value)
                                  },
                                  cursorColor: buttonColor,
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        12, 12, 12, 12),
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
                                  ),
                                )),
                            Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: const Text("/20",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold))),
                            CustomButton(
                                onPressed: () => ExamManager.saveScore(
                                    AdminStart.selectedStudent!),
                                padding: const EdgeInsets.only(right: 14),
                                margin: const EdgeInsets.only(right: 20),
                                width: 70,
                                height: 70,
                                buttonColor: buttonColor,
                                icon: const Icon(
                                  Icons.save,
                                  size: 40,
                                ),
                                borderRadius: 35)
                          ]),
                          AdminStart.selectedStudent!.leftAppCount > 0
                              ? Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      "Examen " +
                                          AdminStart
                                              .selectedStudent!.leftAppCount
                                              .toString() +
                                          "x verlaten",
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red)),
                                )
                              : Container()
                        ])),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 20, 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(blurRadius: 5, color: Colors.grey)
                          ],
                          borderRadius: BorderRadius.circular(25)),
                      child: Column(
                        children: [
                          Container(
                              height: 70,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 5,
                                        offset: Offset(0, 3))
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25.0)),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 50),
                                    child: const Text(
                                      "Antwoorden",
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                ],
                              )),
                          Expanded(
                              child: Container(
                            padding: const EdgeInsets.only(bottom: 20, top: 20),
                            child: ListView.builder(
                                itemCount: AdminStart
                                    .selectedStudent!.exam!.questions!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return _buildRow(index);
                                }),
                          ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
