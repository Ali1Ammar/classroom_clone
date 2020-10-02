import 'package:auto_route/auto_route.dart';
import 'package:colleage/api/course.dart';
import 'package:colleage/api/http_error.dart';
import 'package:colleage/modal/course.dart';
import 'package:colleage/modal/link.dart';
import 'package:colleage/shared/pref.dart';
import 'package:colleage/shared/stage.dart';
import 'package:colleage/shared/theme.dart';
import 'package:colleage/state/global.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class AddCoursePage extends StatefulWidget {
  AddCoursePage({
    Key key,
    this.old,
    this.oldIndex,
  }) : super(key: key);
  final Course old;
  final int oldIndex;
  @override
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  TextEditingController titleCont;
  TextEditingController desCont;
  int stage;
  @override
  void initState() {
    // TODO: implement initState

    titleCont = TextEditingController(text: widget?.old?.name);
    desCont = TextEditingController(text: widget?.old?.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("اضافه كورس"),
          actions: <Widget>[
            Builder(builder: (context) {
              return IconButton(
                icon: Icon(
                  Icons.send,
                ),
                onPressed: () async {
                  if (widget.old != null) {
                    Future<DateTime> put;

                    if (titleCont.text != widget.old.name ||
                        desCont.text != widget.old.description) {
                      put = CourseApi.putCourse(
                          titleCont.text == widget.old.name
                              ? null
                              : titleCont.text,
                          desCont.text == widget.old.description
                              ? null
                              : desCont.text,
                          widget.old.id);
                    }

                    if (put == null) {
                      return;
                    }
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (contextalert) {
                          editFuture(put, contextalert, context);
                          return LoadingFlipping.square(
                            size: 70,
                            borderColor: ThemeConfig.mainColors,
                          );
                        });
                  } else {
                    if (titleCont.text.isNotEmpty &&
                        desCont.text.isNotEmpty &&
                        stage != null) {
                      final callAuth = CourseApi.postCourse(
                          titleCont.text, desCont.text, stage);

                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (contextalert) {
                            callAuth.then((value) {
                              ExtendedNavigator.of(contextalert).pop();
                              Global().me.courses.add(value);
                              SharedPerf.saveUser(Global().me);
                              Global().courseState.data.add(value);
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text("تم اضافه")));
                            }).catchError((error) {
                              ExtendedNavigator.of(contextalert).pop();
                              print(error);
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "حدث خطا ما الرجاء اعادة  محاولة")));
                            });
                            return LoadingFlipping.square(
                              size: 70,
                              borderColor: ThemeConfig.mainColors,
                            );
                          });
                    } else {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("الرجاء ادخال جميع معلومات")));
                    }
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
              if (widget.old == null)
                DropdownButton<int>(
                    isExpanded: true,
                    focusColor: ThemeConfig.mainColors,
                    hint: Text("اختر مرحلتك"),
                    value: stage,
                    items: List.generate(
                        4,
                        (i) => DropdownMenuItem(
                            value: i + 1,
                            child: Text(
                              intToStageString(i + 1),
                            ))),
                    onChanged: (val) {
                      setState(() {
                        stage = val;
                      });
                    }),
            ],
          ),
        ),
      ),
    );
  }

  editFuture(Future<DateTime> put, BuildContext contextalert,
      BuildContext context) async {
    try {
      if (put != null) {
        await put;
        Global().courseState.data[widget.oldIndex] = Course(
            titleCont.text,
            widget.old.stage,
            widget.old.department,
            widget.old.id,
            desCont.text,
            widget.old.teacher);
      }
      ExtendedNavigator.of(contextalert).pop();
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("تم اضافه")));
    } catch (e) {
      ExtendedNavigator.of(contextalert).pop();
  print(e);
      print(e.stackTrace);
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("حدث خطا ما الرجاء اعادة  محاولة")));
    }
  }
}
