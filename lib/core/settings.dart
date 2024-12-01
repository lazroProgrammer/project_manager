// import 'package:localstore/localstore.dart';
import 'package:shared_preferences/shared_preferences.dart';

//! steps to add settings values:
//!? 1: add here the variable, key, setter and getter,
//?     and add to the internal and update function.
//!? 2: add code in settings_notifier.dart.
//!? 3: link in settings page.
// //
class SettingsData {
  static late SharedPreferences _preferences;
  static const isLoggedKey = 'login';
  static const darkmodeKey = 'darkmode';

  // static final localDb = Localstore.instance;
  static final SettingsData _instance = SettingsData._internal();
  late bool darkmode;
  final String localId = "setting";

  factory SettingsData() {
    return _instance;
  }

  SettingsData._internal() {
    darkmode = getdark() ?? false;
  }

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
    if (_preferences.getBool(darkmodeKey) == null) {
      // Set a default value if not set
      await setdark(false);
    }
  }

  static Future setLogin(bool logged) async {
    await _preferences.setBool(isLoggedKey, logged);
  }

  static bool? getLogin() => _preferences.getBool(isLoggedKey);

  static Future setdark(bool b) async {
    await _preferences.setBool(darkmodeKey, b);
  }

  static bool? getdark() => _preferences.getBool(darkmodeKey);

  void update({bool? darkTheme}) {
    if (darkTheme != null) {
      setdark(darkTheme);
    }
    darkmode = darkTheme ?? darkmode;
  }
}
