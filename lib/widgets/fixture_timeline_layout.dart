import 'package:boxy/flex.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_football_scrolling_poc/constants/borders.dart';
import 'package:live_football_scrolling_poc/constants/text_styles.dart';

class FixtureTimelineLayout extends StatelessWidget {
  final String time;
  final Widget icon;
  final Widget cardChild;
  final Alignment timeAlignment;
  final EdgeInsets timePadding;
  final Alignment iconAlignment;
  final EdgeInsets iconPadding;

  FixtureTimelineLayout({
    required this.icon,
    required this.time,
    required this.cardChild,
    this.timePadding = EdgeInsets.zero,
    this.iconPadding = EdgeInsets.zero,
    this.timeAlignment = Alignment.center,
    this.iconAlignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BoxyRow(
      children: [
        Padding(
          padding: timePadding + const EdgeInsets.only(left: 8.0),
          child: SizedBox(
            width: 40,
            child: Align(
              alignment: timeAlignment,
              child: Text(
                time,
                style: TextStyles.semiBold12.copyWith(color: theme.colorScheme.primary),
              ),
            ),
          ),
        ),
        Stack(
          alignment: iconAlignment,
          children: [
            Container(width: 1, color: Colors.grey[400]),
            Padding(padding: iconPadding, child: icon),
          ],
        ),
        Dominant.expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 16.0, 10.0),
            child: Material(
              elevation: 8.0,
              shadowColor: Colors.black12,
              borderRadius: Borders.allCorners16,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: cardChild,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
