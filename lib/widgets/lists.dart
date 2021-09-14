import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TabList extends StatelessWidget {
  final Widget sliver;

  TabList(this.sliver);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [sliver]);
  }
}

class AccentColorsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(delegate: SliverChildBuilderDelegate((c, i) {
      return ListTile(title: Text('$i'), tileColor: Colors.accents[i % Colors.accents.length]);
    }));
  }
}

class PrimaryColorsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(delegate: SliverChildBuilderDelegate((c, i) {
      return ListTile(title: Text('$i'), tileColor: Colors.primaries[i % Colors.primaries.length]);
    }));
  }
}
