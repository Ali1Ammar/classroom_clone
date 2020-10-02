import 'package:colleage/modal/user.dart';
import 'package:colleage/state/course_state.dart';

class Global {
  Global._internal();
  static final Global _singleton = Global._internal();
  CourseState _courseState;
  CourseState get courseState {
    if (_courseState == null) _courseState = CourseState();
    return _courseState;
  }

  factory Global() => _singleton;

  User me;
}
