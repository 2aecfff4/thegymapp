import 'package:flutter/material.dart';
import 'package:thegymapp/config.dart';

class HomepageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget> actions;
  final String? title;
  const HomepageAppBar({Key? key, this.title, required this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      toolbarHeight: 50.0,
      title: title != null ? Text(title!) : null,
    );
  }

  @override
  Size get preferredSize => APP_BAR_PREFERRED_SIZE;
}
