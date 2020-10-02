import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:colleage/api/auth.dart';
import 'package:colleage/api/cliemt.dart';
import 'package:colleage/api/course.dart';
import 'package:colleage/modal/course.dart';
import 'package:colleage/screen/lesson_page.dart';
import 'package:colleage/shared/pref.dart';
import 'package:colleage/shared/stage.dart';
import 'package:colleage/shared/theme.dart';
import 'package:colleage/state/course_state.dart';
import 'package:colleage/state/global.dart';
import 'package:colleage/state/lesson_state.dart';
import 'package:colleage/widget/ThreeDotWidget.dart';
import 'package:colleage/widget/name_ava_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:loading_animations/loading_animations.dart';
import '../shared/routes.gr.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final me = Global().me;
    // print("build first home");
    // print(Global().me.toJson());
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(3.0),
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage(Client.dio.options.baseUrl + me.avatar),
            ),
          ),
          title: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          child: Column(
                            children: <Widget>[
                              AppBar(),
                              Container(
                                width: double.maxFinite,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: AutoSizeText(
                                              "معلوماتك",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                              maxLines: 1,
                                            )),
                                        AutoSizeText(
                                          Global().me.name,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                          maxLines: 1,
                                        ),
                                       
                                          AutoSizeText(Global().me.email,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20)),
                                    if (Global().me.isStudent)     AutoSizeText(
                                            intToStageString(
                                                Global().me.student.stage),
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: AutoSizeText(
                                            "معلومات قسمك",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                            maxLines: 1,
                                          )),
                                      AutoSizeText(
                                        Global().me.department.name,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                        maxLines: 1,
                                      ),
                                      AutoSizeText(Global().me.department.about,
                                          // maxLines: 1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20)),
                                    ],
                                  ),
                                ),
                              ), 
                              SizedBox(height: 20,),
                              CircleAvatar(
                                backgroundImage: NetworkImage(Client.dio.options.baseUrl+Global().me.avatar),
                                radius:( MediaQuery.of(context).size.width/3),
                              )
                            ],
                          ),
                        ),
                      ));
            },
            child: AutoSizeText(
              me.name,
            ),
          ),
          actions: <Widget>[
            if (me.isTeacher)
              IconButton(
                  onPressed: () {
                    ExtendedNavigator.of(context).pushAddcourse();
                  },
                  icon: Icon(Icons.add)),
            FlatButton(
                child: Text(
                  "تسجيل خروج",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  SharedPerf.clearUser();

                  ExtendedNavigator.of(context)
                      .pushNamedAndRemoveUntil(Routes.login, (route) => false);
                })
          ],
        ),
        body: (me.isStudent && me.approved == 0)
            ? Center(
                child: Text(
                "حسابك قيد التفعيل من المسؤول ",
                style: TextStyle(fontSize: 20),
              ))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "كورساتي",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Observer(builder: (
                      context,
                    ) {
                      final snap = Global().courseState;
                      // snap.data.forEach((e) {
                      //   print(e.toJson());
                      // });
                      // print(snap.data.where((e) => e.teacher==null).toList().length);
                      if (snap.hasError) {
                        print(snap.error);
                        // //Error().stackTrace
                        print(snap.error.stackTrace);

                        return Text(snap.error.toString());
                      }
                      if (!snap.hasData && snap.state == StateLoaading.loaded) {
                        return Text("no data");
                      }
                      if (!snap.hasData &&
                          snap.state == StateLoaading.loading) {
                        return LoadingBouncingGrid.circle();
                      }
                      if (!snap.hasData) {
                        return Center(
                            child: Text(
                          "لا تمنتمي لاي دروس حاليا تواصل من استاذك لاضافتك",
                          style: TextStyle(fontSize: 20),
                        ));
                      }
                      //   print());
                      snap.data.forEach((e) {
                        print(e.toJson());
                      });
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: snap.data.length,
                        itemBuilder: (context, i) {
                          final course = snap.data.elementAt(i);
                          var textStyle = TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                          );
                          return InkWell(
                            onTap: () {
                              ExtendedNavigator.of(context).pushCourse(
                                  course: course,
                                  state: LessonState(course.id));
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
                                  ExtendedNavigator.of(context)
                                      .pushAddcourse(old: course, oldIndex: i);
                                }, Text("تعديل")),
                                ThreeDotDto(() async {
                                  try {
                                    await CourseApi.deleteCourse(course.id);
                                    Scaffold.of(context).showSnackBar(
                                        SnackBar(content: Text("تم حذف")));
                                    snap.data.removeAt(i);
                                  } catch (e) {
                                    Scaffold.of(context).showSnackBar(
                                        SnackBar(content: Text("خطا في حذف ")));
                                    //  widget.comments.insert(widget.index, removed);
                                    //setState(() {});
                                  }
                                }, Text("مسح"))
                              ],
                              child: Card(
                                elevation: 4,
                                shadowColor: ThemeConfig.mainColors,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 7, right: 7),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      AutoSizeText(
                                        course?.name ?? "",
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      AutoSizeText(
                                        course?.description ?? "",
                                        maxLines: 3,
                                        style: textStyle,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      //  if (me.isStudent)
                                      Card(
                                        margin: EdgeInsets.zero,
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: NameAndAvatar(
                                            name: Global().me.isStudent
                                                ? course.teacher.user.name
                                                : Global().me.name,
                                            avatar: Global().me.isStudent
                                                ? course.teacher.user.avatar
                                                : Global().me.avatar,
                                          ),
                                        ),
                                      ),
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
