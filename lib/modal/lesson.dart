import 'package:json_annotation/json_annotation.dart';

part 'lesson.g.dart';

@JsonSerializable()
class Lesson {
  final int id;
  final String title;
  final String description;
  @JsonKey(name: "updated_at")
  final DateTime date;
  Lesson(this.id, this.title, this.description, this.date);

  static Lesson fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
  Map<String, dynamic> toJson() => _$LessonToJson(this);
}
