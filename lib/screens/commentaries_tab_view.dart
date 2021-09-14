import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_football_scrolling_poc/constants/colors.dart';
import 'package:live_football_scrolling_poc/constants/text_styles.dart';
import 'package:live_football_scrolling_poc/data/comment.dart';
import 'package:live_football_scrolling_poc/widgets/circle_icon.dart';
import 'package:live_football_scrolling_poc/widgets/fixture_timeline_layout.dart';

class CommentariesTabView extends StatefulWidget {
  @override
  _CommentariesTabViewState createState() => _CommentariesTabViewState();
}

class _CommentariesTabViewState extends State<CommentariesTabView> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      slivers: [_buildListSliver()],
    );
  }

  Widget _buildListSliver() {
    return _CommentariesSliverList(
      commentaries: List.generate(
          115,
          (index) => Comment(index, index + 1, index % 10 == 0,
              'You are now reading comment number ${index + 1}, and it is just a placeholder and not a real comment.')),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _CommentariesSliverList extends StatelessWidget {
  final List<Comment> commentaries;

  const _CommentariesSliverList({required this.commentaries});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) => _CommentListItem(comment: commentaries[i]),
        childCount: commentaries.length,
      ),
    );
  }
}

class _CommentListItem extends StatelessWidget {
  final Comment comment;

  const _CommentListItem({required this.comment});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return FixtureTimelineLayout(
      time: comment.time,
      timePadding: const EdgeInsets.only(top: 24.0),
      timeAlignment: Alignment.topCenter,
      icon: CircularCard(
        iconSize: 20.0,
        iconColor: theme.colorScheme.primary,
        iconPadding: const EdgeInsets.all(6.0),
        image: AssetImage('icons/ic_commentary.png'),
      ),
      iconAlignment: Alignment.topCenter,
      iconPadding: const EdgeInsets.only(top: 18.0),
      cardChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (comment.goal)
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                'Goal!',
                style: TextStyles.semiBold14.copyWith(color: theme.colorScheme.primary),
              ),
            ),
          Text(
            comment.commentText,
            style: TextStyles.regular14.copyWith(color: AppColors.textDarkGray),
          ),
        ],
      ),
    );
  }
}