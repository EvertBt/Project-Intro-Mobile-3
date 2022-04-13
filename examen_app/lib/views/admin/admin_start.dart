import 'package:examen_app/views/admin/changepassword.dart';
import 'package:examen_app/config/constants.dart';
import 'package:flutter/material.dart';

class AdminStart extends StatefulWidget {
  const AdminStart({Key? key}) : super(key: key);

  @override
  State<AdminStart> createState() => _AdminStart();
}

class _AdminStart extends State<AdminStart> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text("Studenten"),
    Text("Examen"),
    ChangePassword()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
                  child: BottomNavigationBar(
                    elevation: 0,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.people),
                        label: 'Studenten',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.book),
                        label: 'Examen',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.lock),
                        label: 'Wachtwoord wijzigen',
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    backgroundColor: primaryColor,
                    selectedItemColor: Colors.white,
                    onTap: _onItemTapped,
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
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            homeRoute, (route) => false);
                      },
                      style: TextButton.styleFrom(primary: Colors.white),
                      child: const Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 35,
                      )),
                )
              ],
            )));
  }
}
