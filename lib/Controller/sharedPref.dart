import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefController {


static late SharedPreferences _preferences;

static Future<void> init() async {
  _preferences = await SharedPreferences.getInstance();

}
  
static Future setNotif(String key, int value) async {
  await _preferences.setInt(key, value);
  }

static int getNotif(String key) {
  return _preferences.getInt(key) ?? 0;
}







}