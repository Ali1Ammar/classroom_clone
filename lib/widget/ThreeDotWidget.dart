import 'package:flutter/material.dart';

class ThreeDotEdit<T> extends StatelessWidget {
  final List<ThreeDotDto> children;
  final Widget child;
  final bool buildThis;
  final T initialValue;

  final PopupMenuCanceled onCanceled;

  final String tooltip;

  final double elevation;

  final EdgeInsetsGeometry padding;

  final Widget icon;

  final Offset offset;
  final AlignmentGeometry alignment;
  final bool enabled;

  final ShapeBorder shape;

  final Color color;

  final bool captureInheritedThemes;
  const ThreeDotEdit(
      {Key key,
      @required this.children,
      @required this.child,
      this.initialValue,
      this.onCanceled,
      this.tooltip,
      this.elevation,
      this.padding = const EdgeInsets.all(8.0),
      this.icon,
      this.offset = Offset.zero,
      this.enabled = true,
      this.shape,
      this.color,
      this.captureInheritedThemes = true,
      this.alignment, this.buildThis=true})
      : assert(offset != null),
        assert(enabled != null),
        assert(captureInheritedThemes != null),
     
           
        super(key: key);
  Widget build(BuildContext context) {
    return buildThis == true ?  Stack(
      children: <Widget>[
        child,
        Positioned.fill(
          child: Align(
            alignment: alignment ?? Alignment.topRight,
            child: PopupMenuButton(
                enabled: enabled,
                captureInheritedThemes: captureInheritedThemes,
                color: color,
                elevation: elevation,
                icon: icon,
                
                initialValue: initialValue,
                offset: offset,
                padding: padding,
                onCanceled: onCanceled,
                shape: shape,
                tooltip: tooltip,
                onSelected: (val) {
                  val();
                },
                itemBuilder: (context) => children
                    .map((e) => PopupMenuItem(child: e.child, value: e.onTap))
                    .toList()),
          ),
        )
      ],
    ) : child;
 
  }
}

class ThreeDotDto {
  final Function onTap;
  final Widget child;

  ThreeDotDto(
    this.onTap,
    this.child,
  );
}
