// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) {
  return Course(
    json['name'] as String,
    saveToInt(json['stage']),
    json['department'] == null
        ? null
        : Department.fromJson(json['department'] as Map<String, dynamic>),
    json['id'] as int,
    json['description'] as String,
    json['teacher'] == null
        ? null
        : Teacher.fromJson(json['teacher'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'department': instance.department,
      'teacher': instance.teacher,
      'stage': instance.stage,
    };
