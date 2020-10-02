import 'dart:convert';

import 'package:colleage/api/cliemt.dart';
import 'package:colleage/modal/comment.dart';
import 'package:colleage/modal/course.dart';
import 'package:colleage/modal/lesson.dart';
import 'package:colleage/modal/link.dart';
import 'package:colleage/state/global.dart';
import 'package:dio/dio.dart';

class CourseApi {
  // static Future<List<Course>> getCourses() async {
  //   final res = await Client.dio
  //       .get("users/get/course/", options: Options(extra: {"hastoken": true}));
  //   print(res.data);
  //   return (res.data as List).map<Course>((e) => Course.fromJson(e)).toList();
  // }

  static Future<List<Lesson>> getCourseDetals(int courseId) async {
    print("called $courseId");
    print(Global().me.token);
    final res = await Client.dio
        .get("lessons/$courseId", options: Options(extra: {"hastoken": true}));
    // print(res.data);
    return (res.data as List).map<Lesson>((e) => Lesson.fromJson(e)).toList();
  }

  static Future<Course> postCourse(String name, String des, int stage) async {
    final res = await Client.dio
        .post("courses", options: Options(extra: {"hastoken": true}), data: {
      "name": name,
      "description": des,
      "stage": stage,
    });
    return Course.fromJson(res.data);
  }

  static Future<DateTime> putCourse(String name, String des, int id) async {
    final res = await Client.dio
        .put("courses/$id", options: Options(extra: {"hastoken": true}), data: {
      if (name != null) "name": name,
      if (des != null) "description": des,
    });
    print(res.data);
    return DateTime.parse(res.data);
  }

  static Future<void> deleteCourse(int id) async {
    await Client.dio
        .delete("courses/$id", options: Options(extra: {"hastoken": true}));
  }
}
