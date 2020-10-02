import 'package:after_layout/after_layout.dart';
import 'package:auto_route/auto_route.dart';
import 'package:colleage/shared/pref.dart';
import 'package:colleage/shared/routes.gr.dart';
import 'package:colleage/shared/theme.dart';
import 'package:colleage/state/global.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import 'package:loading_animations/loading_animations.dart';

class HandleStart extends StatefulWidget {
  @override
  _HandleStartState createState() => _HandleStartState();
}

class _HandleStartState extends State<HandleStart> with AfterLayoutMixin {
  @override
  initState() {
    super.initState();
  }

  @override
  afterFirstLayout(BuildContext context) async {
    final user = await SharedPerf.getUser();
    //await Future.delayed(Duration(milliseconds: 2000));
    if (user == null) {
      ExtendedNavigator.of(context)
          .pushNamedAndRemoveUntil(Routes.login, (route) => false);
    } else {
      Global().me = user;
      Global().courseState.init(user.token);
      ExtendedNavigator.of(context)
          .pushNamedAndRemoveUntil(Routes.home, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FittedBox(
          child: LoadingFadingLine.square(
            size: 500,
            borderColor: ThemeConfig.mainColors,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
