
import 'package:colleage/api/course.dart';
import 'package:colleage/api/department.dart';
import 'package:colleage/modal/department.dart';
import 'package:colleage/modal/lesson.dart';
import 'package:colleage/service/auth_service.dart';
import 'package:colleage/shared/user_enum.dart';
import 'package:colleage/state/global.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

import 'course_state.dart';

part 'lesson_state.g.dart';

class LessonState extends _LessonState with _$LessonState {
  LessonState(int courseId) : super(courseId);
}

abstract class _LessonState with Store {
  final int courseId;
  _LessonState(this.courseId) {
    CourseApi.getCourseDetals(courseId).then((value) {
      data = ObservableList.of(value);
      state = StateLoaading.loaded;
    }).catchError((error) {
      state = StateLoaading.error;
    });
  }
  @observable
  StateLoaading state = StateLoaading.loading;
  @observable
  ObservableList<Lesson> data;
  dynamic error;

  bool get hasData => data != null;
  bool get hasError => error != null;
}


