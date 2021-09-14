import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_football_scrolling_poc/constants/borders.dart';
import 'package:live_football_scrolling_poc/constants/text_styles.dart';
import 'package:live_football_scrolling_poc/data/fixture_details.dart';
import 'package:live_football_scrolling_poc/widgets/lists.dart';
import 'package:live_football_scrolling_poc/widgets/one_line_text.dart';
import 'package:live_football_scrolling_poc/widgets/player_image.dart';
import 'package:live_football_scrolling_poc/widgets/team_lineup.dart';

class LineupsTabView extends StatefulWidget {
  final FixtureDetails fixture;

  LineupsTabView(this.fixture);

  @override
  _LineupsTabViewState createState() => _LineupsTabViewState();
}

class _LineupsTabViewState extends State<LineupsTabView> with AutomaticKeepAliveClientMixin{
  FixtureDetails get fixture => widget.fixture;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      key: PageStorageKey<String>('lineups'),
      slivers: [
        SliverList(delegate: SliverChildListDelegate(_buildLineups())),
        SliverToBoxAdapter(child: _buildCoaches()),
        AccentColorsList(),
      ],
    );
  }

  List<Widget> _buildLineups() {
    return [
      LocalTeamLineupWidget(fixture.localTeamLineup),
      VisitorTeamLineupWidget(fixture.visitorTeamLineup),
    ];
  }

  Widget _buildCoaches() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        elevation: 0.0,
        borderRadius: Borders.allCorners20,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Manager', style: TextStyles.semiBold16),
              const SizedBox(height: 10.0),
              Row(children: [
                PlayerImage.network(radius: 20, logoPath: null),
                const SizedBox(width: 6.0),
                Expanded(
                  child: OneLineText(style: TextStyles.regular14, text: "Local Team's Manager"),
                ),
                Expanded(
                  child: OneLineText(
                    textAlign: TextAlign.end,
                    style: TextStyles.regular14,
                    text: "Visitor Team's Manager",
                  ),
                ),
                const SizedBox(width: 6.0),
                PlayerImage.network(radius: 20, logoPath: null),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
