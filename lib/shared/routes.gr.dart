// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:colleage/screen/login_page.dart';
import 'package:colleage/screen/signin_page.dart';
import 'package:colleage/state/signin.dart';
import 'package:colleage/screen/home_page.dart';
import 'package:colleage/screen/handle_start_page.dart';
import 'package:colleage/screen/course_page.dart';
import 'package:colleage/modal/course.dart';
import 'package:colleage/state/lesson_state.dart';
import 'package:colleage/screen/lesson_page.dart';
import 'package:colleage/modal/lesson.dart';
import 'package:colleage/screen/add_course.dart';
import 'package:colleage/screen/add_lesson.dart';

abstract class Routes {
  static const login = '/login';
  static const signin = '/signin';
  static const home = '/home';
  static const init = '/';
  static const course = '/course';
  static const lesson = '/lesson';
  static const addcourse = '/addcourse';
  static const addLesson = '/add-lesson';
  static const all = {
    login,
    signin,
    home,
    init,
    course,
    lesson,
    addcourse,
    addLesson,
  };
}

class MyRouter extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<MyRouter>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.login:
        if (hasInvalidArgs<LoginPageArguments>(args)) {
          return misTypedArgsRoute<LoginPageArguments>(args);
        }
        final typedArgs = args as LoginPageArguments ?? LoginPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => LoginPage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.signin:
        if (hasInvalidArgs<SigninPageArguments>(args)) {
          return misTypedArgsRoute<SigninPageArguments>(args);
        }
        final typedArgs = args as SigninPageArguments ?? SigninPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              SigninPage(key: typedArgs.key, state: typedArgs.state),
          settings: settings,
        );
      case Routes.home:
        if (hasInvalidArgs<HomePageArguments>(args)) {
          return misTypedArgsRoute<HomePageArguments>(args);
        }
        final typedArgs = args as HomePageArguments ?? HomePageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomePage(key: typedArgs.key),
          settings: settings,
        );
      case Routes.init:
        return MaterialPageRoute<dynamic>(
          builder: (context) => HandleStart(),
          settings: settings,
        );
      case Routes.course:
        if (hasInvalidArgs<CoursePageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<CoursePageArguments>(args);
        }
        final typedArgs = args as CoursePageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => CoursePage(
              key: typedArgs.key,
              course: typedArgs.course,
              state: typedArgs.state),
          settings: settings,
        );
      case Routes.lesson:
        if (hasInvalidArgs<LessonPageArguments>(args)) {
          return misTypedArgsRoute<LessonPageArguments>(args);
        }
        final typedArgs = args as LessonPageArguments ?? LessonPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => LessonPage(
              key: typedArgs.key,
              lesson: typedArgs.lesson,
              course: typedArgs.course),
          settings: settings,
        );
      case Routes.addcourse:
        if (hasInvalidArgs<AddCoursePageArguments>(args)) {
          return misTypedArgsRoute<AddCoursePageArguments>(args);
        }
        final typedArgs =
            args as AddCoursePageArguments ?? AddCoursePageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => AddCoursePage(
              key: typedArgs.key,
              old: typedArgs.old,
              oldIndex: typedArgs.oldIndex),
          settings: settings,
        );
      case Routes.addLesson:
        if (hasInvalidArgs<AddLessonPageArguments>(args)) {
          return misTypedArgsRoute<AddLessonPageArguments>(args);
        }
        final typedArgs =
            args as AddLessonPageArguments ?? AddLessonPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => AddLessonPage(
              key: typedArgs.key,
              courseId: typedArgs.courseId,
              lessonState: typedArgs.lessonState,
              oldLisien: typedArgs.oldLisien,
              oldLessonIndex: typedArgs.oldLessonIndex),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//LoginPage arguments holder class
class LoginPageArguments {
  final Key key;
  LoginPageArguments({this.key});
}

//SigninPage arguments holder class
class SigninPageArguments {
  final Key key;
  final SigninState state;
  SigninPageArguments({this.key, this.state});
}

//HomePage arguments holder class
class HomePageArguments {
  final Key key;
  HomePageArguments({this.key});
}

//CoursePage arguments holder class
class CoursePageArguments {
  final Key key;
  final Course course;
  final LessonState state;
  CoursePageArguments({this.key, @required this.course, @required this.state});
}

//LessonPage arguments holder class
class LessonPageArguments {
  final Key key;
  final Lesson lesson;
  final Course course;
  LessonPageArguments({this.key, this.lesson, this.course});
}

//AddCoursePage arguments holder class
class AddCoursePageArguments {
  final Key key;
  final Course old;
  final int oldIndex;
  AddCoursePageArguments({this.key, this.old, this.oldIndex});
}

//AddLessonPage arguments holder class
class AddLessonPageArguments {
  final Key key;
  final int courseId;
  final LessonState lessonState;
  final Lesson oldLisien;
  final int oldLessonIndex;
  AddLessonPageArguments(
      {this.key,
      this.courseId,
      this.lessonState,
      this.oldLisien,
      this.oldLessonIndex});
}

// *************************************************************************
// Navigation helper methods extension
// **************************************************************************

extension MyRouterNavigationHelperMethods on ExtendedNavigatorState {
  Future pushLogin({
    Key key,
  }) =>
      pushNamed(
        Routes.login,
        arguments: LoginPageArguments(key: key),
      );

  Future pushSignin({
    Key key,
    SigninState state,
  }) =>
      pushNamed(
        Routes.signin,
        arguments: SigninPageArguments(key: key, state: state),
      );

  Future pushHome({
    Key key,
  }) =>
      pushNamed(
        Routes.home,
        arguments: HomePageArguments(key: key),
      );

  Future pushInit() => pushNamed(Routes.init);

  Future pushCourse({
    Key key,
    @required Course course,
    @required LessonState state,
  }) =>
      pushNamed(
        Routes.course,
        arguments: CoursePageArguments(key: key, course: course, state: state),
      );

  Future pushLesson({
    Key key,
    Lesson lesson,
    Course course,
  }) =>
      pushNamed(
        Routes.lesson,
        arguments:
            LessonPageArguments(key: key, lesson: lesson, course: course),
      );

  Future pushAddcourse({
    Key key,
    Course old,
    int oldIndex,
  }) =>
      pushNamed(
        Routes.addcourse,
        arguments:
            AddCoursePageArguments(key: key, old: old, oldIndex: oldIndex),
      );

  Future pushAddLesson({
    Key key,
    int courseId,
    LessonState lessonState,
    Lesson oldLisien,
    int oldLessonIndex,
  }) =>
      pushNamed(
        Routes.addLesson,
        arguments: AddLessonPageArguments(
            key: key,
            courseId: courseId,
            lessonState: lessonState,
            oldLisien: oldLisien,
            oldLessonIndex: oldLessonIndex),
      );
}
