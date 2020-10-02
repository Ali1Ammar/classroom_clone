import 'package:json_annotation/json_annotation.dart';

part 'department.g.dart';
@JsonSerializable()
class Department {
 final int id;
 final String name;
 final String about;

  Department(this.id, this.name, this.about);
    static Department fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);
  Map<String, dynamic> toJson() => _$DepartmentToJson(this);
}