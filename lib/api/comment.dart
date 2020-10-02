import 'package:colleage/api/cliemt.dart';
import 'package:colleage/modal/comment.dart';
import 'package:dio/dio.dart';

class CommentsApi {
  static Future<Comment> post(String txt, int lessonId) async {
    final res = await Client.dio.post("comments",
        data: {"text": txt, "lesson_id": lessonId},
        options: Options(
          extra: {"hastoken": true},
        ));
        print(res.data);
    return Comment.fromJson(res.data);
  }

 static Future<DateTime> put(String txt, int commentId) async {
    final res = await Client.dio.put("comments/$commentId",
        data: {"text": txt},
        options: Options(
          extra: {"hastoken": true},
        ));
        print(res.data);
    return DateTime.parse(res.data);
  }

 static Future<void> delete( int commentId) async {
    await Client.dio.delete("comments/$commentId",
        options: Options(
          extra: {"hastoken": true},
        ));
    return;
  }

//   Delete http://localhost:8000/comments/{comment_id}
// post http://localhost:8000/comments   require lesson_id and text
// put  http://localhost:8000/comments/{comment_id} require text
}

enum Operationedit { edit , delete}
extension Ar on Operationedit {
  String get toAr=>this == Operationedit.delete ? "مسح" : "تعديل" ;
}