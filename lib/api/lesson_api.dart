import 'package:colleage/api/cliemt.dart';
import 'package:colleage/api/course.dart';
import 'package:colleage/modal/comment.dart';
import 'package:colleage/modal/lesson.dart';
import 'package:colleage/modal/link.dart';
import 'package:dio/dio.dart';

class LessonApi {
  static Future<LessonDetalsDto> getLessonDetals(int lessonId) async {
    final res = await Client.dio.get("lessons/show/$lessonId",
        options: Options(extra: {"hastoken": true}));
    print(res.data["comments"]);
    final links =
        (res.data["links"] as List).map<Link>((e) => Link.fromJson(e)).toList();
    final commens = (res.data["comments"] as List)
        .map<Comment>((e) => Comment.fromJson(e))
        .toList();
    return LessonDetalsDto(links, commens);
  }

  static Future<Lesson> postLesson(
      String name, String des, List<Map> links, int courseId) async {
    //   print(jsonEncode( links.map((e) => {"link": e}).toList()));
    final res = await Client.dio
        .post("lessons", options: Options(extra: {"hastoken": true}), data: {
      "title": name,
      "description": des,
      "course_id": courseId,
      "links":links
    });
    //   print(res.data);
    return Lesson.fromJson(res.data);
  }

  static Future<DateTime> putLesson(
      String name, String des, int lessonId) async {
    final res = await Client.dio.put("lessons/$lessonId",
        options: Options(extra: {"hastoken": true}),
        data: {
          if (name != null) "title": name,
          if (des != null) "description": des,
        });
    return res.data;
  }

  static Future<Link> postLink(String link, String name , int lessonId) async {
    final res = await Client.dio.post("links",
        options: Options(extra: {"hastoken": true}),
        data: {"link": link, "name" : name , "lesson_id": lessonId});
    return Link.fromJson(res.data);
  }

  static Future<void> deleteLesson(int lessonId) async {
    //   print(jsonEncode( links.map((e) => {"link": e}).toList()));
    await Client.dio.delete(
      "lessons/$lessonId",
      options: Options(extra: {"hastoken": true}),
    );

    return;
  }
    static Future<void> deleteLink(int linkId) async {
    //   print(jsonEncode( links.map((e) => {"link": e}).toList()));
    await Client.dio.delete(
      "links/$linkId",
      options: Options(extra: {"hastoken": true}),
    );

    return;
  }
}

class LessonDetalsDto {
  final List<Link> links;
  final List<Comment> comments;

  const LessonDetalsDto(this.links, this.comments);
}
