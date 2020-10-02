import 'package:auto_size_text/auto_size_text.dart';
import 'package:colleage/api/cliemt.dart';
import 'package:colleage/api/comment.dart';
import 'package:colleage/api/course.dart';
import 'package:colleage/api/lesson_api.dart';
import 'package:colleage/modal/comment.dart';
import 'package:colleage/modal/course.dart';
import 'package:colleage/modal/lesson.dart';
import 'package:colleage/modal/link.dart';
import 'package:colleage/modal/teacher.dart';
import 'package:colleage/screen/course_page.dart';
import 'package:colleage/shared/theme.dart';
import 'package:colleage/state/global.dart';
import 'package:colleage/widget/comment_widget.dart';
import 'package:colleage/widget/customdropmenu.dart';
import 'package:colleage/widget/links_widget.dart';
import 'package:colleage/widget/name_ava_row.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:timeago/timeago.dart';
import 'package:url_launcher/url_launcher.dart';

class LessonPage extends StatefulWidget {
  final Lesson lesson;
  final Course course;

  LessonPage({
    Key key,
    this.lesson,
    this.course,
  }) : super(key: key);

  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> with TickerProviderStateMixin {
  bool expandComment = false;
  Future<LessonDetalsDto> getLessonDetals;
  bool expandFile = false;
  TextEditingController _commentsCont;
  @override
  void initState() {
    super.initState();
    getLessonDetals = LessonApi.getLessonDetals(widget.lesson.id);
    _commentsCont = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _commentsCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      color: Colors.black87,
      fontSize: 18,
    );
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   print(widget.lesson.id);
      // }),
      appBar: AppBar(
        title: Text(
          widget.lesson.title,
          maxLines: 1,
        ),
      //  actions: <Widget>[IconButton(icon: Icon(Icons.add), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildCardTeacherCourseDetals(),
            buildCardDesc(),
            FutureBuilder<LessonDetalsDto>(
                future: getLessonDetals,
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return LoadingFadingLine.circle();
                  }
                  if (snap.hasError) {
                    return Text(snap.error.toString());
                  }
                  if (!snap.hasData) {
                    return Text("no data");
                  }

                  return Column(
                    children: <Widget>[
                      buildStatefulBuilderFile(snap.data.links, textStyle),
                      buildStatefulBuilderComments(
                          snap.data.comments, textStyle)
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }

  StatefulBuilder buildStatefulBuilderComments(
      List<Comment> comments, TextStyle textStyle) {
    return StatefulBuilder(
        builder: (context, setaState) => Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ExpandIcon(
                          isExpanded: expandComment,
                          onPressed: (isExp) {
                            setaState(() {
                              expandComment = !isExp;
                            });
                          }),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Stack(
                            children: <Widget>[
                              TextField(
                                controller: _commentsCont,
                                decoration: InputDecoration(
                                  labelText: "علق",
                                  prefixIcon: SizedBox(),
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                ),
                              ),
                              IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    addComments(comments, setaState, context);
                                  })
                            ],
                          ),
                        ),
                      ),
                      Text(
                        "تعليقات  ${comments.length}",
                      ),
                    ],
                  ),
                ),
                if (comments.isNotEmpty)
                  AnimatedSize(
                      vsync: this,
                      duration: Duration(milliseconds: 300),
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: <Widget>[
                          for (var i = 0;
                              i <
                                  (expandComment
                                      ? comments.length
                                      : ((comments.length > 2)
                                          ? 2
                                          : comments.length));
                              i++)
                            CommentCard(
                               key: ValueKey(comments[comments.length-1-i]),
                              comments: comments,
                              index: comments.length - 1 - i,
                            )
                        ],
                      )),
              ],
            ));
  }

  StatefulBuilder buildStatefulBuilderFile(
      List<Link> links, TextStyle textStyle) {
    return StatefulBuilder(builder: (context, setaState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ExpandIcon(
                    isExpanded: expandFile,
                    onPressed: (isExp) {
                      setaState(() {
                        expandFile = !isExp;
                      });
                    }),
                Text(
                  "مرفقات ${links.length}",
                ),
              ],
            ),
          ),
          AnimatedSize(
            vsync: this,
            duration: Duration(milliseconds: 300),
            child: ListView(
                  reverse: true,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    for (var i = 0; i < (expandFile ? (  links.length>2 ? 2 :  links.length ) : links.length); i++)
                      InkWell(
                        onTap: () async {
                          print(links[i].link);
                          if (!await canLaunch(links[i].link)) {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("خطا في رابط")));
                          } else {
                            launch(links[i].link);
                            print("hhh");
                          }
                        },
                        child: LinkCard(
                          index: i,
                          links: links,
                        ),
                      )
                  ],
                ) 
          ),
        ],
      );
    });
  }

  Widget buildCardDesc() {
    return SizedBox(
      width: double.maxFinite,
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(widget.lesson.description,
            style: TextStyle(fontSize: 20, color: Colors.white)),
      )),
    );
  }

  Widget buildCardTeacherCourseDetals() {
    return SizedBox(
      width: double.maxFinite,
      child: Card(
        color: ThemeConfig.mainColors,
        child: Padding(
          padding: EdgeInsets.all(
            7,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(widget.course.name,
                      style: TextStyle(fontSize: 20, color: Colors.white70)),
                  Text(
                    format(widget.lesson.date, locale: "ar"),
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              NameAndAvatar(
                name: Global().me.isStudent
                    ? widget.course.teacher.user.name
                    : Global().me.name,
                avatar: Global().me.isStudent
                    ? widget.course.teacher.user.avatar
                    : Global().me.avatar,
              ),
            ],
          ),
        ),
      ),
    );
  }

  addComments(
    List<Comment> comments,
    Function setaState,
    BuildContext context,
  ) async {
    print("commetns here");
    print(_commentsCont.value.text);
    print(_commentsCont.text);

    if (_commentsCont.text.isNotEmpty) {
      final commentNoId =
          Comment(null, _commentsCont.value.text, Global().me, DateTime.now());
      comments.add(commentNoId);

      setaState(() {});
      try {
        final comment =
            await CommentsApi.post(_commentsCont.text, widget.lesson.id);
        _commentsCont.clear();
        commentNoId.id = comment.id;
        // final index = comments.indexOf(commentNoId);
        // print(comment.date);
        // if (index != -1) {
        //   comments[index] =
        //       Comment(comment.id, comment.text, commentNoId.user, comment.date);
        // }
      } catch (e) {
        print(e);
        final index = comments.lastIndexOf(commentNoId);
        if (index != -1) {
          comments.removeAt(index);
        }
        setaState(() {});
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("خطا في اضافه تعليق")));
      }
    }
  }
}
