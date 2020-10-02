
import 'package:colleage/api/cliemt.dart';
import 'package:colleage/modal/department.dart';

class DepartmentApi {
  static Future<List<Department>> gets() async {
    final res = await Client.dio.get("departments");
    return (res.data as List).map<Department>(((e) => Department.fromJson(e))).toList();
  }
}