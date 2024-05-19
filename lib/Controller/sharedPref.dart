import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefController {
  static late SharedPreferences _preferences;
  static final StreamController<int> _notifCountController = StreamController<int>.broadcast();

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> setNotif(String key, int value) async {
    await _preferences.setInt(key, value);
    _notifCountController.add(value);
  }

  static int getNotif(String key) {
    return _preferences.getInt(key) ?? 0;
  }

  static Stream<int> get notifCountStream => _notifCountController.stream;

  static void dispose() {
    _notifCountController.close();
  }
}
