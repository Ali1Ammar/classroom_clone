import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:colleage/api/cliemt.dart';
import 'package:colleage/api/course.dart';
import 'package:colleage/api/lesson_api.dart';
import 'package:colleage/modal/course.dart';
import 'package:colleage/modal/lesson.dart';
import 'package:colleage/shared/theme.dart';
import 'package:colleage/state/course_state.dart';
import 'package:colleage/state/global.dart';
import 'package:colleage/state/lesson_state.dart';
import 'package:colleage/widget/ThreeDotWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:timeago/timeago.dart';
import '../shared/routes.gr.dart';

class CoursePage extends StatelessWidget {
  final me = Global().me;
  final Course course;
  final LessonState state;
  CoursePage({Key key, @required this.course, @required this.state})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
   
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
         if(Global().me.isTeacher)   IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  ExtendedNavigator.of(context)
                      .pushAddLesson(courseId: course.id, lessonState: state);
                })
          ],
          title: Text(
            course.name,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "دروسي",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Observer(
                  //   future: CourseApi.getCourseDetals(course.id),
                  builder: (
                context,
              ) {
                final snap = state;
                if (snap.state == StateLoaading.loading) {
                  return LoadingFadingLine.circle();
                }
                if (snap.hasError) {
                  return Text(snap.error.toString());
                }
                if (!snap.hasData) {
                  return Text("no data");
                }
                final lessons = snap.data;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: lessons.length,
                  reverse: true,
                  itemBuilder: (context, i) {
                    final lesson = lessons.elementAt(i);
                    var textStyle = TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    );
                    return InkWell(
                      onTap: () async {
                        ExtendedNavigator.of(context).pushLesson(
                          lesson: lesson,
                          course: course,
                        );
                      },
                      child: ThreeDotEdit(
                        buildThis: Global().me.isTeacher,
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                        color: Colors.white,
                        children: [
                          ThreeDotDto(() {
                            ExtendedNavigator.of(context).pushAddLesson(
                                courseId: course.id,
                                oldLessonIndex: i,
                                lessonState: state,
                                oldLisien: lesson);
                          }, Text("تعديل")),
                          ThreeDotDto(() async {
                            try {
                              await LessonApi.deleteLesson(lesson.id);
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text("تم حذف")));
                              lessons.removeAt(i);
                            } catch (e) {
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text("خطا في حذف ")));
                              //  widget.comments.insert(widget.index, removed);
                              //setState(() {});
                            }
                          }, Text("مسح"))
                        ],
                        child: Card(
                          color: ThemeConfig.mainColors,
                          elevation: 4,
                          // shadowColor: ThemeConfig.mainColors,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 7, right: 7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                AutoSizeText(
                                  lesson.title ?? "",
                                  maxLines: 1,
                                  style: textStyle,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                AutoSizeText(
                                  lesson?.description ?? "",
                                  maxLines: 2,
                                  style: textStyle,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      format(lesson.date, locale: "ar"),
                                      style: TextStyle(color: Colors.white60),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
