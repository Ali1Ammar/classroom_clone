import 'package:auto_size_text/auto_size_text.dart';
import 'package:colleage/api/cliemt.dart';
import 'package:flutter/material.dart';

class NameAndAvatar extends StatelessWidget {
  const NameAndAvatar({
    Key key, this.name, this.avatar,
   
  }) : super(key: key);

  final String name;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        AutoSizeText(
        name,
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        CircleAvatar(
          backgroundImage: NetworkImage(Client.dio.options.baseUrl +
       avatar),
        ),
      ],
    );
  }
}