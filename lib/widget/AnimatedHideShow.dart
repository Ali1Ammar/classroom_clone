import 'package:flutter/material.dart';

class AnimatedHideShow extends StatelessWidget {
  const AnimatedHideShow({
    Key key,
    @required this.isShow,
    this.secondChild,
    this.firstChild,
    this.firstBuilder,
    this.secondBuilder,
    this.duration = const Duration(milliseconds: 500),
  }) : super(key: key);

  final Widget firstChild;
  final Widget secondChild;
  final WidgetBuilder firstBuilder;
  final WidgetBuilder secondBuilder;
  final bool isShow;
  final Duration duration;
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstCurve: Curves.elasticIn,
      secondCurve: Curves.slowMiddle,
      duration: duration,
      sizeCurve: Curves.easeOutQuint,
      firstChild: firstBuilder == null
          ? firstChild ?? SizedBox()
          : firstBuilder(context),
      secondChild: secondBuilder == null
          ? secondChild ?? SizedBox()
          : secondBuilder(context),
      crossFadeState:
          isShow ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }
}
