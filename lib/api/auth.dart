import 'package:colleage/api/cliemt.dart';
import 'package:colleage/modal/course.dart';
import 'package:colleage/modal/department.dart';
import 'package:colleage/modal/user.dart';
import 'package:colleage/shared/user_enum.dart';
import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';

class AuthApi {
  static Future<String> login(String email, String password) async {
    final token = await Client.dio
        .post("login", data: {"email": email, "password": password});
    return token.data['token'];
    //  return token.data['token'];
  }

  static Future<String> register(String name, String email, String password,
      Department department, UserType type, String avatarPath,
      [int stage]) async {
    if (type == UserType.student && stage == 0)
      throw "must have stage for student";
   print("register");
    final token = await Client.dio.post("register",
        data: FormData.fromMap({
          "full_name": name,
          "email": email,
          "password": password,
          "department_id": department.id,
          "type": EnumToString.parse(type),
          "avatar": MultipartFile.fromFileSync(avatarPath),
          if (stage != null) "stage": stage
        }));
        print(token);
    return token.data['token'];

    // return token.data['token'];
  }

  static Future<User> getUserData(String token) async {
    print("get user data");
    final res = await Client.dio.get("/users/AuthData",
        options: Options(headers: {"Authorization": "bearer $token"}));
    res.data["token"] = token;
    final data = User.fromJson(res.data);
   print(res.data);
     print(data.courses);
    return data;
  }
}
