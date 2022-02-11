import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double radius;

  final double? iconSize;

  const Avatar({Key? key, this.radius = 40, this.iconSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CircleAvatar(
      backgroundColor: theme.highlightColor,
      child: Icon(
        Icons.person,
        color: theme.disabledColor,
        size: iconSize,
      ),
      radius: radius,
    );
  }
}
