import 'package:examen_app/home.dart';
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
    Text('Wachtwoord wijzigen')
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 100.0,
                height: 57.0,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 174, 15, 11),
                ),
                child: const Image(image: AssetImage('assets/logo.png'))),
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
                backgroundColor: const Color.fromARGB(255, 174, 15, 11),
                selectedItemColor: Colors.white,
                onTap: _onItemTapped,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 174, 15, 11),
              ),
              height: 57.0,
              width: 100.0,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Home()));
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
