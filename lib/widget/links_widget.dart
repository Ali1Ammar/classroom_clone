import 'package:auto_size_text/auto_size_text.dart';
import 'package:colleage/api/cliemt.dart';

import 'package:colleage/api/comment.dart';
import 'package:colleage/api/lesson_api.dart';

import 'package:colleage/modal/link.dart';
import 'package:colleage/shared/theme.dart';
import 'package:colleage/state/global.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart';

class LinkCard extends StatefulWidget {
  const LinkCard({
    Key key,
    this.index,
    this.links,
  }) : super(key: key);

  final int index;
  final List<Link> links;

  @override
  _LinkCardState createState() => _LinkCardState();
}

class _LinkCardState extends State<LinkCard> {
  Link link;

  bool delete = false;
  @override
  void initState() {
    super.initState();
    link = widget.links[widget.index];
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
                  AutoSizeText(
                    link.name ?? link.link ?? "",
                    maxLines: 1,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  if (Global().me.isTeacher)
                    IconButton(
                      icon: Icon(Icons.delete_outline,color: Colors.white,),
                      onPressed: deleteItem,
                    )
                  // PopupMenuButton<Operationedit>(
                  //   color: Colors.white,
                  //   elevation: 4,
                  //   icon: Icon(
                  //     Icons.more_horiz,
                  //     color: Colors.white,
                  //   ),
                  //   itemBuilder: (context) => Operationedit.values
                  //       .map((e) => PopupMenuItem(
                  //             child: Text(
                  //               e.toAr,
                  //               textDirection: TextDirection.rtl,
                  //               textAlign: TextAlign.end,
                  //             ),
                  //             value: e,
                  //           ))
                  //       .toList(),
                  //   onSelected: (val) async {
                  //     if (val == Operationedit.delete) {
                  //       deleteItem();
                  //     } else {
                  //       setState(() {
                  //         _textEditingController =
                  //             TextEditingController(text: link.text);
                  //         edit = true;
                  //       });
                  //     }
                  //   },
                  // ),
                ],
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
      await LessonApi.deleteLink(link.id);
      widget.links.removeAt(widget.index);
    } catch (e) {
      delete = true;
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("خطا في حذف رابط")));
      //  widget.links.insert(widget.index, removed);
      setState(() {});
    }
  }
}
