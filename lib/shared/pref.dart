import 'dart:convert';

import 'package:colleage/modal/user.dart';
import 'package:colleage/state/course_state.dart';
import 'package:colleage/state/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPerf {
  static Future<void> saveUser(User user) async {
    final p = await SharedPreferences.getInstance();
    p.setString("user", jsonEncode(user.toJson()));
  }

  static Future<void> clearUser() async {
    final p = await SharedPreferences.getInstance();
    p.remove("user");
    Global().me = null;
    Global().courseState.data.clear();
    Global().courseState.state = StateLoaading.loading;
  }

  static Future<User> getUser() async {
    final p = await SharedPreferences.getInstance();
    final userString = p.getString("user");
    if (userString == null) {
      return null;
    }
    return User.fromJson(jsonDecode(userString));
  }
}
