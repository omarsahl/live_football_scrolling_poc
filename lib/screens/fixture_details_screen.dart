import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_football_scrolling_poc/constants/colors.dart';
import 'package:live_football_scrolling_poc/data/fixture_details.dart';
import 'package:live_football_scrolling_poc/data/scorers.dart';
import 'package:live_football_scrolling_poc/screens/commentaries_tab_view.dart';
import 'package:live_football_scrolling_poc/screens/lineups_tab_view.dart';
import 'package:live_football_scrolling_poc/widgets/fixture_details_bar.dart';
import 'package:live_football_scrolling_poc/widgets/lists.dart';
import 'package:live_football_scrolling_poc/widgets/scorers_sliver_list.dart';

final fixtureDetails = FixtureDetails();

const double _toolbarHeight = 60.0;

typedef _FixtureDetailsTabBuilder = Widget Function(FixtureDetails fixture);

class _FixtureDetailsTabModel {
  final String title;
  final _FixtureDetailsTabBuilder builder;

  Tab get tab => Tab(text: title);

  _FixtureDetailsTabModel({required this.title, required this.builder});
}

class FixtureDetailsScreen extends StatefulWidget {
  @override
  _FixtureDetailsScreenState createState() => _FixtureDetailsScreenState();
}

class _FixtureDetailsScreenState extends State<FixtureDetailsScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<_FixtureDetailsTabModel> _tabs = [
    _FixtureDetailsTabModel(
      title: 'Match Details',
      builder: (fixture) => TabList(AccentColorsList()),
    ),
    _FixtureDetailsTabModel(
      title: 'Lineups',
      builder: (fixture) => LineupsTabView(fixture),
    ),
    _FixtureDetailsTabModel(
      title: 'Commentaries',
      builder: (fixture) => CommentariesTabView(),
    ),
    _FixtureDetailsTabModel(
      title: "Stats",
      builder: (fixture) => TabList(AccentColorsList()),
    ),
    _FixtureDetailsTabModel(
      title: 'Standings',
      builder: (fixture) => TabList(PrimaryColorsList()),
    ),
    _FixtureDetailsTabModel(
      title: "H2H",
      builder: (fixture) => TabList(AccentColorsList()),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            _buildAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                child: FixtureDetailsBar(),
              ),
            ),
            ScorersSliverList(scorers: scorers),
            SliverPadding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              sliver: _buildMainTabBar(),
            ),
          ];
        },
        body: _buildTabView(),
      ),
    );
  }

  Widget _buildAppBar() {
    ThemeData theme = Theme.of(context);
    return SliverAppBar(
      pinned: true,
      toolbarHeight: _toolbarHeight,
      shadowColor: Colors.black12,
      backgroundColor: theme.scaffoldBackgroundColor,
      title: Text('La Liga'),
    );
  }

  Widget _buildMainTabBar() {
    ThemeData theme = Theme.of(context);
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SingleChildHeaderDelegate(
        backgroundColor: theme.scaffoldBackgroundColor,
        child: TabBar(
          isScrollable: true,
          labelColor: theme.colorScheme.onPrimary,
          indicatorColor: theme.colorScheme.primary,
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor: AppColors.textDarkGray,
          controller: _tabController,
          indicator: ShapeDecoration(
            color: theme.colorScheme.primary,
            shape: const StadiumBorder(side: BorderSide.none),
          ),
          tabs: _tabs.map((e) => e.tab).toList(),
        ),
      ),
    );
  }

  Widget _buildTabView() {
    return TabBarView(
      controller: _tabController,
      children: _tabs.map((e) => e.builder(fixtureDetails)).toList(),
    );
  }
}

class _SingleChildHeaderDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSizeWidget child;
  final Color? backgroundColor;

  _SingleChildHeaderDelegate({required this.child, this.backgroundColor});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return backgroundColor == null
        ? child
        : Material(
            child: child,
            color: backgroundColor,
            elevation: overlapsContent ? 4.0 : 0.0,
          );
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(covariant _SingleChildHeaderDelegate oldDelegate) {
    return child.preferredSize != oldDelegate.child.preferredSize;
  }
}
