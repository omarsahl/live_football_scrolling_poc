import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircularCard extends StatelessWidget {
  final IconData? icon;
  final ImageProvider? image;
  final Widget? child;
  final double? elevation;
  final Color? backgroundColor;
  final Color? shadowColor;
  final EdgeInsets iconPadding;
  final double? iconSize;
  final Color? iconColor;

  CircularCard({
    this.icon,
    this.image,
    this.child,
    this.elevation,
    this.backgroundColor,
    this.shadowColor,
    this.iconPadding = const EdgeInsets.all(8.0),
    this.iconSize = 24.0,
    this.iconColor,
  }) : assert((icon != null && image == null && child == null) ||
            (icon == null && image != null && child == null) ||
            (icon == null && image == null && child != null));

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    Widget? iconWidget;

    if (child != null) {
      iconWidget = child;
    }
    if (iconWidget == null && icon != null) {
      iconWidget = Icon(
        icon,
        size: iconSize,
        color: iconColor ?? theme.colorScheme.primary,
      );
    }
    if (iconWidget == null && image != null) {
      iconWidget = ImageIcon(
        image,
        size: iconSize,
        color: iconColor,
      );
    }

    if (iconWidget == null) throw 'At least one of child, icon or image must be not null';

    return Material(
      shape: const CircleBorder(),
      type: MaterialType.card,
      shadowColor: shadowColor ?? Colors.black12,
      elevation: elevation ?? theme.cardTheme.elevation ?? 8.0,
      child: Padding(padding: iconPadding, child: iconWidget),
    );
  }
}
