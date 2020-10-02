import 'package:colleage/api/auth.dart';
import 'package:colleage/api/course.dart';
import 'package:colleage/api/department.dart';
import 'package:colleage/modal/course.dart';
import 'package:colleage/modal/department.dart';
import 'package:colleage/modal/user.dart';
import 'package:colleage/service/auth_service.dart';
import 'package:colleage/shared/pref.dart';
import 'package:colleage/shared/user_enum.dart';
import 'package:colleage/state/global.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'course_state.g.dart';

class CourseState = _CourseState with _$CourseState;

abstract class _CourseState with Store {
  _CourseState() {
    // init();
  }

  Future<User> init(String token) async {
    if (Global()?.me?.courses != null && Global().me.courses.isNotEmpty) {
      data = ObservableList.of(Global().me.courses);
    }
    try {
      final value = await AuthApi.getUserData(token);
      print("end get user data");
    
      
      Global().me = value;
      SharedPerf.saveUser(value);
      print("set Global().me get user data");
      print(value.toJson());
      data = ObservableList.of(value.courses);
      state = StateLoaading.loaded;
      return value;
    } catch (e) {
      state = StateLoaading.error;
      error = e;
      throw e;

    }

  }

  @observable
  StateLoaading state = StateLoaading.loading;
  @observable
  ObservableList<Course> data;
  dynamic error;

  bool get hasData => data != null;
  bool get hasError => error != null;
}

enum StateLoaading { loading, loaded, error }
