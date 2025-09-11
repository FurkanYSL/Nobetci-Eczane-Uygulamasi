import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nobetci_eczane_app/constants/app_strings.dart';

class LocationService {
  Future<Map<String, String>?> getCurrentCityDistrict() async {
    bool locationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationEnabled) {
      return null;
    }
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return null;
      }
    }
    if (locationPermission == LocationPermission.deniedForever) {
      return null;
    }
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (placemarks.isNotEmpty) {
      String city = placemarks[0].administrativeArea ?? AppStrings.emptyString;
      String district =
          placemarks[0].subAdministrativeArea ?? AppStrings.emptyString;
      return {"city": city, "district": district};
    }
    return null;
  }

  Future<Position?> getCurrentPosition() async {
    final bool locationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationEnabled) {
      return null;
    }

    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return null;
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      return null;
    }

    return Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
  }
}
