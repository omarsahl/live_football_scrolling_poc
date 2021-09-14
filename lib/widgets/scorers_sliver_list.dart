import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:live_football_scrolling_poc/constants/colors.dart';
import 'package:live_football_scrolling_poc/constants/text_styles.dart';
import 'package:live_football_scrolling_poc/data/scorers.dart';
import 'package:live_football_scrolling_poc/widgets/one_line_text.dart';

class ScorersSliverList extends StatelessWidget {
  final Scorers scorers;

  ScorersSliverList({required this.scorers});

  @override
  Widget build(BuildContext context) {
    final localScorers = scorers.localScorers;
    final visitorScorers = scorers.visitorScorers;

    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          return Row(
            children: [
              _buildScorerListItem(localScorers, i, true),
              i == 0
                  ? Image.asset('icons/ic_football.png', height: 16, width: 16)
                  : Container(width: 20.0),
              _buildScorerListItem(visitorScorers, i, false),
            ],
          );
        },
        childCount: max(localScorers.length, visitorScorers.length),
      ),
      itemExtent: 24.0,
    );
  }

  Widget _buildScorerListItem(List<String> scorers, int index, bool isLocal) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        child: scorers.length > index
            ? OneLineText(
                text: scorers[index],
                textAlign: isLocal ? TextAlign.end : TextAlign.start,
                style: TextStyles.regular12.copyWith(color: AppColors.textDarkGray),
              )
            : Container(),
      ),
    );
  }
}
