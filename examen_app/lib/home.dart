import 'package:examen_app/colors.dart';
import 'package:examen_app/login.dart';
import 'package:examen_app/student_home.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(child: Text('Examen App')),
          backgroundColor: CustomColor.primary,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 150.0,
              margin:
                  const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StudentHome()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: CustomColor.button,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.all(8.0),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Student',
                    style: TextStyle(fontSize: 50.0),
                  )),
            ),
            Container(
              width: double.infinity,
              height: 150.0,
              margin:
                  const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        NoAnimationMaterialPageRoute(
                            builder: (context) => const Login()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: CustomColor.button,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.all(8.0),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Admin',
                    style: TextStyle(fontSize: 50.0),
                  )),
            ),
          ],
        )),
        bottomNavigationBar: Container(
            height: 56.0,
            padding: const EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
                color: CustomColor.primary,
                boxShadow: const [
                  BoxShadow(blurRadius: 6.0, offset: Offset(0, 2.0))
                ]),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 13.0),
                  child: const Image(
                    image: AssetImage('assets/logosmall.png'),
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ],
            )));
  }
}

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
            builder: builder,
            maintainState: maintainState,
            settings: settings,
            fullscreenDialog: fullscreenDialog);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
