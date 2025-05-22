import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends ChangeNotifier {
  /// Instance of the Settings
  static final Settings _instance = Settings._internal();

  /// private Constructor
  Settings._internal();

  /// get instance
  factory Settings.instance() {
    return _instance;
  }

  /// List of groups
  static const String _pref = "pref";

  /// Instance of prefs
  late SharedPreferences _prefs;

  /// Initialize the SharedPreference
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Preference can Filter Words
  static const String prefCanFilterWords = "$_pref:canFilterWords";

  /// getter
  bool get canFilterWords {
    return _prefs.getBool(prefCanFilterWords) ?? true;
  }

  /// setter
  Future<void> setCanFilterWords(bool value) async {
    return _prefs.setBool(prefCanFilterWords, value).then((_) {
      notifyListeners();
    });
  }

  /// Preference language
  static const String prefLanguage = "$_pref:language";

  /// getter
  String get language {
    return _prefs.getString(prefLanguage) ?? 'en';
  }

  /// setter
  Future<void> setLanguage(String value) async {
    return _prefs.setString(prefLanguage, value).then((_) {
      notifyListeners();
    });
  }
}
