import 'dart:io';


 import 'package:flutter_downloader/flutter_downloader.dart';


import 'package:shared_preferences/shared_preferences.dart';

import 'StringConstants.dart';

class SharedObjects {
  static late CachedSharedPreferences prefs;




}

class CachedSharedPreferences {
  static late  SharedPreferences sharedPreference;
  static late CachedSharedPreferences instance;
  static final cachedKeyList = {
    StringConstants.firstRun,
    StringConstants.sessionUid,
    StringConstants.sessionUsername,
    StringConstants.sessionName,
    StringConstants.sessionProfilePictureUrl,
    StringConstants.configDarkMode,

  };
  static final sessionKeyList = {
    StringConstants.sessionName,
    StringConstants.sessionUid,
    StringConstants.sessionUsername,
    StringConstants.sessionProfilePictureUrl
  };

  static Map<String, dynamic> map = Map();

  static Future<CachedSharedPreferences> getInstance() async {
    sharedPreference = await SharedPreferences.getInstance();
    if (sharedPreference.getBool(StringConstants.firstRun) == null || sharedPreference.get(StringConstants.firstRun)=="")
    { // if first run, then set these values
      await sharedPreference.setBool(StringConstants.configDarkMode, false);
      await sharedPreference.setBool(StringConstants.firstRun, false);
    }
    for (String key in cachedKeyList) {
      map[key] = sharedPreference.get(key);
    }
    if (instance == null) instance = CachedSharedPreferences();
    return instance;
  }

  String? getString(String key) {
    if (cachedKeyList.contains(key)) {
      return map[key];
    }
    return sharedPreference.getString(key);
  }

  bool? getBool(String key) {
    if (cachedKeyList.contains(key)) {
      return map[key];
    }
    return sharedPreference.getBool(key);
  }

  Future<bool> setString(String key, String value) async {
    bool result = await sharedPreference.setString(key, value);
    if (result)
      map[key] = value;
    return result;
  }

  Future<bool> setBool(String key, bool value) async {
    bool result = await sharedPreference.setBool(key, value);
    if (result)
      map[key] = value;
    return result;
  }

  Future<void> clearAll() async {
    await sharedPreference.clear();
    map = Map();
  }

  Future<void> clearSession() async {
    await sharedPreference.remove(StringConstants.sessionProfilePictureUrl);
    await sharedPreference.remove(StringConstants.sessionUsername);
    await sharedPreference.remove(StringConstants.sessionUid);
    await sharedPreference.remove(StringConstants.sessionName);
    map.removeWhere((k, v) => (sessionKeyList.contains(k)));
  }
}
