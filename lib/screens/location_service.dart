import 'package:geolocator/geolocator.dart';
import 'privacy_settings.dart';

class LocationService {
  /// GPS only if Privacy "Share location" is ON and OS permission is granted.
  static Future<Position?> getPositionIfAllowed() async {
    final allowedInApp = await PrivacySettings.getShareLocation();
    if (!allowedInApp) return null;

    final serviceOn = await Geolocator.isLocationServiceEnabled();
    if (!serviceOn) return null;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
  }

  /// When user turns ON "Share location" in Privacy.
  static Future<bool> requestPermissionFromPrivacy() async {
    final serviceOn = await Geolocator.isLocationServiceEnabled();
    if (!serviceOn) return false;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }
}