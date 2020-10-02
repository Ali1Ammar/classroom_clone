import 'package:auto_size_text/auto_size_text.dart';
import 'package:colleage/api/cliemt.dart';
import 'package:colleage/api/comment.dart';
import 'package:colleage/modal/comment.dart';
import 'package:colleage/shared/theme.dart';
import 'package:colleage/state/global.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({
    Key key,
    this.index,
    this.comments,
  }) : super(key: key);

  final int index;
  final List<Comment> comments;

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  Comment comment;
  bool edit = false;
  bool delete = false;
  TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    comment = widget.comments[widget.index];
  }

  @override
  Widget build(BuildContext context) {
    if (delete) {
      return SizedBox();
    } else {
      return Card(
        color: ThemeConfig.mainColors,
        elevation: 1,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 7, right: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        Client.dio.options.baseUrl + comment.user.avatar),
                  ),
                  AutoSizeText(
                    comment.user.name,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  if (comment.user.id == Global().me.id)
                    PopupMenuButton<Operationedit>(
                      color: Colors.white,
                      elevation: 4,
                      icon: Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                      itemBuilder: (context) => Operationedit.values
                          .map((e) => PopupMenuItem(
                                child: Text(
                                  e.toAr,
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.end,
                                ),
                                value: e,
                              ))
                          .toList(),
                      onSelected: (val) async {
                        if (val == Operationedit.delete) {
                          deleteItem();
                        } else {
                          setState(() {
                            _textEditingController =
                                TextEditingController(text: comment.text);
                            edit = true;
                          });
                        }
                      },
                    ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                              child: Text(
                  format(comment.date, locale: "ar"),
                  style: TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ),
              if (edit)
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        autofocus: true,
                        decoration: InputDecoration(
                          isDense: true,
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                        onSubmitted: (val) {},
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                        onPressed: () {
                          editItem();
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ))
                  ],
                )
              else
                AutoSizeText(
                  comment.text ?? "",
                  maxLines: 1,
                  style: TextStyle(color: Colors.white),
                ),
            ],
          ),
        ),
      );
    }
  }

  Future<void> deleteItem() async {
    delete = true;
    setState(() {});
    try {
      await CommentsApi.delete(comment.id);
      widget.comments.removeAt(widget.index);
    } catch (e) {
      delete = true;
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("خطا في حذف تعليق")));
      //  widget.comments.insert(widget.index, removed);
      setState(() {});
    }
  }

  editItem() async {
    final oldComment = comment;
    try {
      comment = oldComment.copyWith(
          text: _textEditingController.text, date: DateTime.now());
      edit = false;
      setState(() {});

      final newDate =
          await CommentsApi.put(_textEditingController.text, comment.id);
      comment =
          comment.copyWith(text: _textEditingController.text, date: newDate);
      setState(() {});
    } catch (e) {
      print(e);
      comment = oldComment;
      setState(() {});
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("خطا في تعديل تعليق")));
    }
  }
}
