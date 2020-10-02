import 'package:colleage/modal/department.dart';
import 'package:colleage/modal/parse_int.dart';
import 'package:colleage/modal/teacher.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {
  final int id;
  final String name;
  final String description;
  final Department department;
  final Teacher teacher;
  @JsonKey(fromJson: saveToInt)
  final int stage;

  Course(this.name, this.stage, this.department, this.id, this.description,
      this.teacher);
  static Course fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
