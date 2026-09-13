import 'package:shared_preferences/shared_preferences.dart';

class PrivacySettings {
  static const _keyShareLocation = 'privacy_share_location';
  static const _keySharePhoto = 'privacy_share_photo';
  static const _keyAllowContact = 'privacy_allow_contact';
  static const _keyAnalytics = 'privacy_analytics';
  static const _keyTips = 'privacy_tips';
  static const _keyOnline = 'privacy_online';

  static Future<bool> getShareLocation() async {
    final p = await SharedPreferences.getInstance();
    return p.getBool(_keyShareLocation) ?? true;
  }

  static Future<void> setShareLocation(bool value) async {
    final p = await SharedPreferences.getInstance();
    await p.setBool(_keyShareLocation, value);
  }

  static Future<bool> getSharePhoto() async {
    final p = await SharedPreferences.getInstance();
    return p.getBool(_keySharePhoto) ?? true;
  }

  static Future<void> setSharePhoto(bool value) async {
    final p = await SharedPreferences.getInstance();
    await p.setBool(_keySharePhoto, value);
  }

  static Future<bool> getAllowContact() async {
    final p = await SharedPreferences.getInstance();
    return p.getBool(_keyAllowContact) ?? true;
  }

  static Future<void> setAllowContact(bool value) async {
    final p = await SharedPreferences.getInstance();
    await p.setBool(_keyAllowContact, value);
  }

  static Future<Map<String, bool>> loadAll() async {
    final p = await SharedPreferences.getInstance();
    return {
      'shareLocation': p.getBool(_keyShareLocation) ?? true,
      'sharePhoto': p.getBool(_keySharePhoto) ?? true,
      'allowContact': p.getBool(_keyAllowContact) ?? true,
      'analytics': p.getBool(_keyAnalytics) ?? false,
      'tips': p.getBool(_keyTips) ?? true,
      'online': p.getBool(_keyOnline) ?? false,
    };
  }

  static Future<void> saveAll({
    required bool shareLocation,
    required bool sharePhoto,
    required bool allowContact,
    required bool analytics,
    required bool tips,
    required bool online,
  }) async {
    final p = await SharedPreferences.getInstance();
    await p.setBool(_keyShareLocation, shareLocation);
    await p.setBool(_keySharePhoto, sharePhoto);
    await p.setBool(_keyAllowContact, allowContact);
    await p.setBool(_keyAnalytics, analytics);
    await p.setBool(_keyTips, tips);
    await p.setBool(_keyOnline, online);
  }
}