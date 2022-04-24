import 'package:examen_app/config/constants.dart';
import 'package:examen_app/helpers/locationrequester.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  void getLocationPermission() async {
    await Locator.askPermission();
  }

  @override
  void initState() {
    getLocationPermission();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Center(
                  child: Text(
                'Home',
                style: TextStyle(fontSize: 30),
              )),
              backgroundColor: primaryColor,
            ),
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 150.0,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 100.0, vertical: 20.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, studentHomeRoute);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: buttonColor,
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
                  margin: const EdgeInsets.symmetric(
                      horizontal: 100.0, vertical: 20.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, loginRoute);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: buttonColor,
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
                width: double.infinity,
                height: 56.0,
                padding: const EdgeInsets.only(left: 20.0),
                decoration: const BoxDecoration(
                    color: primaryColor,
                    boxShadow: [
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
                ))));
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
