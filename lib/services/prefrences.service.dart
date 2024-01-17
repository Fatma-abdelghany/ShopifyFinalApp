import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    try {
      _prefsInstance = await SharedPreferences.getInstance();
      return _prefsInstance;
    } catch (e) {
      print(
          "===================== Errror from sharedpreference ${e.toString()}");
    }
    return null;
  }

// to  access this private parameter  _prefsInstance
// must use get method to return this private parameter
  static SharedPreferences? get getPrefsInstance => _prefsInstance;
}
