import 'package:colleage/modal/course.dart';
import 'package:colleage/modal/department.dart';
import 'package:colleage/modal/student.dart';
import 'package:colleage/modal/teacher.dart';
import 'package:colleage/shared/user_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  @JsonKey(name: "full_name")
  final String name;
  final String email;
  final String avatar;
  final Department department;
  final int approved;
  final Teacher teacher;
  final Student student;
  final String token;
  final UserType type;
  User(
      {this.approved,
      this.type,
      this.teacher,
      this.student,
      this.id,
      this.name,
      this.email,
      this.avatar,
      this.department,
      this.token});
  static User fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  bool get isTeacher => type == UserType.teacher;
  bool get isStudent => type == UserType.student;
    @JsonKey(ignore: true)
  List<Course> get courses {
    if (isTeacher) return teacher?.courses;
    if (isStudent) return student?.courses;
    return null;
  }
//  @JsonKey(ignore: true)
//     set courses( List<Course> courses) {
//     // if (teacher != null)  teacher.courses=courses;
//     // if (student != null)  student.courses=courses;
//     //return null;
//   }
 
}
