// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    approved: json['approved'] as int,
    type: _$enumDecodeNullable(_$UserTypeEnumMap, json['type']),
    teacher: json['teacher'] == null
        ? null
        : Teacher.fromJson(json['teacher'] as Map<String, dynamic>),
    student: json['student'] == null
        ? null
        : Student.fromJson(json['student'] as Map<String, dynamic>),
    id: json['id'] as int,
    name: json['full_name'] as String,
    email: json['email'] as String,
    avatar: json['avatar'] as String,
    department: json['department'] == null
        ? null
        : Department.fromJson(json['department'] as Map<String, dynamic>),
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'full_name': instance.name,
      'email': instance.email,
      'avatar': instance.avatar,
      'department': instance.department,
      'approved': instance.approved,
      'teacher': instance.teacher,
      'student': instance.student,
      'token': instance.token,
      'type': _$UserTypeEnumMap[instance.type],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$UserTypeEnumMap = {
  UserType.teacher: 'teacher',
  UserType.student: 'student',
  UserType.admin: 'admin',
};
