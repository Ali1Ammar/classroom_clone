import 'package:colleage/modal/user.dart';
import 'package:json_annotation/json_annotation.dart';

import 'course.dart';

part 'teacher.g.dart';

@JsonSerializable()
class Teacher {
  final User user;
  final List<Course> courses;
   Teacher({this.user, this.courses});
  static Teacher fromJson(Map<String, dynamic> json) => _$TeacherFromJson(json);
  Map<String, dynamic> toJson() => _$TeacherToJson(this);

}
