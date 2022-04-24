import 'package:location/location.dart';

class Locator {
  static Location location = Location();

  static Future<String> getLocation() async {
    bool _serviceEnabled;
    LocationData? _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return "error";
      }
    }

    if (await askPermission()) {
      _locationData = await location.getLocation();
    }

    return "lat=${_locationData!.latitude.toString()}&lon=${_locationData.longitude.toString()}";
  }

  static Future<bool> askPermission() async {
    PermissionStatus _permissionGranted;
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }
}
