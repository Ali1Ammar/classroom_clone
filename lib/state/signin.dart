import 'package:colleage/api/department.dart';
import 'package:colleage/modal/department.dart';
import 'package:colleage/modal/user.dart';
import 'package:colleage/service/auth_service.dart';
import 'package:colleage/shared/user_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'signin.g.dart';

class SigninState = _SigninState with _$SigninState;

abstract class _SigninState with Store {
  _SigninState() {
    _setDepart();
  }
  _setDepart() async {
    await Future.delayed(Duration(seconds: 3));
    departments = await DepartmentApi.gets();
  }

  @observable
  UserType typeChecked;
  @action
  void checkType(UserType type) {
    typeChecked = type;
  }

  // String email;
  // String password;
  Department department;

  @observable
  List<Department> departments;
  @observable
  int stage;
  @observable
  PickedFile avatar;

  Future<User> register(String name, String email, String password) async {
    return await Auth.signin(
        name, email, password, department, typeChecked, avatar.path, stage);
  }
}
