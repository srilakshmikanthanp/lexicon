import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  /// Map of Key to List of Listeners for the property
  Map<String, List<ValueSetter<String>>> listeners = {};

  /// remove the listener
  bool removeListener(String key, ValueSetter<String> fn) {
    return listeners.putIfAbsent(key, () => []).remove(fn);
  }

  /// add a listener
  void addListener(String key, ValueSetter<String> fn) {
    listeners.putIfAbsent(key, () => []).add(fn);
  }

  /// notify all the listeners
  void _notifyListeners(String key) {
    listeners.putIfAbsent(key, () => []).forEach((fn) {
      fn(key);
    });
  }

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
      _notifyListeners(prefCanFilterWords);
    });
  }
}
