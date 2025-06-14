import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<Placemark> getCurrentPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location permission denied forever');
      }
    }
    // print('Location services are disabled');
    // return Future.error('Location services are disabled');
  }

  // Get current postion
  Position position = await Geolocator.getCurrentPosition();

  // Convert position to placemark
  List<Placemark> placemarks = await placemarkFromCoordinates(
    position.latitude,
    position.longitude,
  );
  Placemark placemark = placemarks.first;

  return placemark;
}
