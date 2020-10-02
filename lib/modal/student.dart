import 'package:colleage/modal/department.dart';
import 'package:colleage/modal/parse_int.dart';
import 'package:json_annotation/json_annotation.dart';

import 'course.dart';

part 'student.g.dart';

@JsonSerializable()
class Student {
  final int id;
  final Reputation reputation;
  @JsonKey(fromJson: saveToInt)
  final int stage;
  final List<Course> courses;
  Student({this.stage, this.id, this.reputation, this.courses});
  static Student fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);
  Map<String, dynamic> toJson() => _$StudentToJson(this);
}

enum Reputation { excellent, good, normal, bad }
