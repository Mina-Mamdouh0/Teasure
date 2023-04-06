// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'common_button.dart';
import 'drawer_widget.dart';

class AppBarIcons extends StatefulWidget {
  final Color? iconColor;

  const AppBarIcons({Key? key, this.iconColor}) : super(key: key);

  @override
  State<AppBarIcons> createState() => _AppBarIconsState();
}

class _AppBarIconsState extends State<AppBarIcons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SplashIcon(
            onPressed: () {
              setState(() {
                ZoomDrawer.of(context)?.toggle();
              });
            },
            icon: Icon(Icons.more_vert_rounded,
                color: widget.iconColor != null && widget.iconColor != ""
                    ? widget.iconColor
                    : Theme.of(context).iconTheme.color),
            size: 28),
      ],
    );
  }
}
