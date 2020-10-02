import 'package:auto_route/auto_route.dart';
import 'package:colleage/api/auth.dart';
import 'package:colleage/modal/department.dart';
import 'package:colleage/modal/user.dart';
import 'package:colleage/shared/pref.dart';
import 'package:colleage/shared/routes.gr.dart';
import 'package:colleage/shared/user_enum.dart';
import 'package:colleage/state/global.dart';
import 'package:flutter/cupertino.dart';

class Auth {
  static Future<User> login(String email, String password) async {
    final token = await AuthApi.login(email, password);
    return await handleSaveUser(token);
    //  return user;
  }

  static Future<User> signin(String name, String email, String password,
      Department department, UserType type, String avatarPath,
      [int stage]) async {
    if (type == UserType.student && stage == 0)
      throw "must have stage for student";
    final token = await AuthApi.register(
        name, email, password, department, type, avatarPath, stage);
    return handleSaveUser(token);
    //return user;
  }

  static Future<User> handleSaveUser(String token) async {
    return await Global().courseState.init(token);
  }
}
