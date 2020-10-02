import 'package:auto_route/auto_route.dart';
import 'package:colleage/api/course.dart';
import 'package:colleage/api/http_error.dart';
import 'package:colleage/api/lesson_api.dart';
import 'package:colleage/modal/lesson.dart';
import 'package:colleage/modal/link.dart';
import 'package:colleage/shared/stage.dart';
import 'package:colleage/shared/theme.dart';
import 'package:colleage/state/global.dart';
import 'package:colleage/state/lesson_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class AddLessonPage extends StatefulWidget {
  final int courseId;
  final LessonState lessonState;
  final Lesson oldLisien;
  final int oldLessonIndex;
  AddLessonPage(
      {Key key,
      this.courseId,
      this.lessonState,
      this.oldLisien,
      this.oldLessonIndex})
      : super(key: key);

  @override
  _AddLessonPageState createState() => _AddLessonPageState();
}

class _AddLessonPageState extends State<AddLessonPage> {
  List<Map<String, String>> links = [];
  TextEditingController linkCont;
  TextEditingController titleCont;
  TextEditingController desCont;
  TextEditingController nameLinkCont;

  @override
  void initState() {
    // TODO: implement initState
    linkCont = TextEditingController();
    nameLinkCont = TextEditingController();
    titleCont = TextEditingController(text: widget?.oldLisien?.title);
    desCont = TextEditingController(text: widget?.oldLisien?.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(widget.oldLisien.id);
          },
        ),
        appBar: AppBar(
          title: Text("اضافه درس"),
          actions: <Widget>[
            Builder(builder: (context) {
              return IconButton(
                icon: Icon(
                  Icons.send,
                ),
                onPressed: () async {
                  if (titleCont.text.isNotEmpty && desCont.text.isNotEmpty) {
                    if (widget.oldLisien != null) {
                      Future<DateTime> put;
                      Future<List<Link>> linksFutues;
                      if (titleCont.text != widget.oldLisien.title ||
                          desCont.text != widget.oldLisien.description) {
                        put = LessonApi.putLesson(
                            titleCont.text == widget.oldLisien.title
                                ? null
                                : titleCont.text,
                            desCont.text == widget.oldLisien.description
                                ? null
                                : desCont.text,
                            widget.oldLisien.id);
                      }
                      if (links.isNotEmpty) {
                        linksFutues = Future.wait(links
                            .map((e) => LessonApi.postLink(
                                e["link"], e["name"], widget.oldLisien.id))
                            .toList());
                      }
                      if (put == null && linksFutues == null) {
                        return;
                      }
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (contextalert) {
                            editLesson(linksFutues, put, contextalert, context);
                            return LoadingFlipping.square(
                              size: 70,
                              borderColor: ThemeConfig.mainColors,
                            );
                          });
                    } else {
                      final callAuth = LessonApi.postLesson(
                          titleCont.text, desCont.text, links, widget.courseId);

                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (contextalert) {
                            callAuth.then((value) {
                              ExtendedNavigator.of(contextalert).pop();
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text("تم اضافه")));
                              widget.lessonState.data.add(value);
                            }).catchError((error) {
                              ExtendedNavigator.of(contextalert).pop();

                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content:
                                      Text("حدث خطا ما الرجاء اعادة  محاولة")));
                            });
                            return LoadingFlipping.square(
                              size: 70,
                              borderColor: ThemeConfig.mainColors,
                            );
                          });
                    }
                  } else {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("الرجاء ادخال جميع معلومات")));
                  }
                },
              );
            })
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: titleCont,
                decoration: InputDecoration(labelText: "عنوان"),
              ),
              TextField(
                  controller: desCont,
                  decoration: InputDecoration(labelText: "الوصف")),
              Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      TextField(
                        controller: linkCont,
                        decoration: InputDecoration(
                          labelText: "اضف رابط",
                          prefixIcon: SizedBox(),
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        // onSubmitted: (val) {
                        //   setState(() {
                        //     links.add(val);
                        //     linkCont.clear();
                        //   });
                        // },
                      ),
                      TextField(
                        controller: nameLinkCont,
                        decoration: InputDecoration(
                          labelText: "اسم رابط ملف ",
                          prefixIcon: SizedBox(),
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        // onSubmitted: (val) {
                        //   setState(() {
                        //     links.add(val);
                        //     linkCont.clear();
                        //   });
                        // },
                      ),
                    ],
                  ),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          links.add({
                            "link": linkCont.text,
                            "name": nameLinkCont.text
                          });
                          linkCont.clear();
                          nameLinkCont.clear();
                        });
                        //addComments(comments, setaState, context);
                      })
                ],
              ),
              Text("روابط"),
              for (var i = 0; i < links.length; i++)
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: ListTile(
                    title: Text(links[i]["name"]),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            links.removeAt(i);
                          });
                        }),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  editLesson(Future<List<Link>> linksFutues, Future<DateTime> put,
      BuildContext contextalert, BuildContext context) async {
    try {
      if (linksFutues != null) {
        await linksFutues;
      }
      if (put != null) {
        final value = await put;
        widget.lessonState.data[widget.oldLessonIndex] =
            Lesson(widget.oldLisien.id, titleCont.text, desCont.text, value);
      }
      ExtendedNavigator.of(contextalert).pop();
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("تم اضافه")));
    } catch (e) {
      ExtendedNavigator.of(contextalert).pop();

      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("حدث خطا ما الرجاء اعادة  محاولة")));
    }
  }
}
