import 'package:auto_route/auto_route_annotations.dart';
import 'package:colleage/screen/add_course.dart';
import 'package:colleage/screen/add_lesson.dart';
import 'package:colleage/screen/course_page.dart';
import 'package:colleage/screen/handle_start_page.dart';
import 'package:colleage/screen/home_page.dart';
import 'package:colleage/screen/lesson_page.dart';
import 'package:colleage/screen/signin_page.dart';
import '../screen/login_page.dart';

@MaterialAutoRouter(generateNavigationHelperExtension: true)
class $MyRouter {
  LoginPage login;

  SigninPage signin;

  HomePage home;
  @initial
  HandleStart init;

  CoursePage course;

  LessonPage lesson;

  AddCoursePage addcourse;
  AddLessonPage addLesson;
}
