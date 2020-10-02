import 'package:colleage/modal/department.dart';
import 'package:colleage/modal/parse_int.dart';
import 'package:colleage/modal/teacher.dart';
import 'package:colleage/modal/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
   int id;
  final String text;
  final User user;

  @JsonKey(name: "updated_at")
  final DateTime date;
  Comment(this.id, this.text, this.user, this.date);
  static Comment fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);

   Comment copyWith({int id, String text, User user, DateTime date}) {
    return Comment(id ?? this.id, text ?? this.text, user ?? this.user, date ?? this.date);
  }
}
 