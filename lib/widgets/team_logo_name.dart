import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TeamLogoAndName extends StatelessWidget {
  final String teamName;
  final String teamLogo;
  final Color? backgroundColor;
  final Color? strokeColor;
  final double? strokeWidth;
  final TextStyle? textStyle;
  final double radius;

  const TeamLogoAndName({
    required this.teamName,
    required this.teamLogo,
    this.radius = 35.0,
    this.backgroundColor,
    this.strokeColor,
    this.strokeWidth,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double iconSize = radius * 1.3;
    return Column(
      children: [
        Material(
          elevation: 0.0,
          shape: CircleBorder(),
          child: CircleAvatar(
            radius: radius,
            backgroundColor: backgroundColor,
            child: Image.asset(teamLogo, height: iconSize, fit: BoxFit.contain),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            teamName,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: textStyle ?? theme.textTheme.headline6,
          ),
        ),
      ],
    );
  }
}
