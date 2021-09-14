import 'dart:math';

import 'package:live_football_scrolling_poc/data/parsed_team_lineup.dart';

const _localImages = [
  'https://cdn.sportmonks.com/images/soccer/players/2/1314.png',
  "https://cdn.sportmonks.com/images/soccer/players/2/1314.png",
  "https://cdn.sportmonks.com/images/soccer/players/23/98903.png",
  "https://cdn.sportmonks.com/images/soccer/players/0/460160.png",
  "https://cdn.sportmonks.com/images/soccer/players/12/268.png",
  "https://cdn.sportmonks.com/images/soccer/players/17/30289.png",
  "https://cdn.sportmonks.com/images/soccer/players/20/159700.png",
  "https://cdn.sportmonks.com/images/soccer/players/15/186543.png",
  "https://cdn.sportmonks.com/images/soccer/players/30/260862.png",
  "https://cdn.sportmonks.com/images/soccer/players/28/93948.png",
  "https://cdn.sportmonks.com/images/soccer/players/15/600687.png",
];

const _visitorImages = [
  "https://cdn.sportmonks.com/images/soccer/players/20/31284.png",
  "https://cdn.sportmonks.com/images//soccer/leagues/26/185530.png",
  "https://cdn.sportmonks.com/images//soccer/leagues/5/96741.png",
  "https://cdn.sportmonks.com/images/soccer/players/21/469717.png",
  "https://cdn.sportmonks.com/images//soccer/leagues/27/537595.png",
  "https://cdn.sportmonks.com/images/soccer/players/14/5640878.png",
  "https://cdn.sportmonks.com/images/soccer/players/8/185480.png",
  "https://cdn.sportmonks.com/images/soccer/players/8/26536.png",
  "https://cdn.sportmonks.com/images/soccer/players/30/184798.png",
  "https://cdn.sportmonks.com/images/soccer/players/19/32403.png",
  "https://cdn.sportmonks.com/images//soccer/leagues/1/37288001.png",
];

class FixtureDetails {
  ParsedTeamLineup localTeamLineup;

  ParsedTeamLineup visitorTeamLineup;

  FixtureDetails()
      : localTeamLineup = generateLineup('Real Madrid', '4-3-3', true),
        visitorTeamLineup = generateLineup('Barcelona', '4-4-2', false);

  static ParsedTeamLineup generateLineup(String teamName, String formation, bool local) {
    final formationElements = [1] + formation.split('-').map((e) => int.parse(e)).toList();

    int start = 1;
    List<ParsedTeamLineupLine> lines = [];
    for (int i = 0; i < formationElements.length; i++) {
      lines.add(generateLine(start, formationElements[i], local));
      start = start + formationElements[i];
    }
    return ParsedTeamLineup(formation, teamName, lines, local);
  }

  static ParsedTeamLineupLine generateLine(int start, int membersCount, bool local) {
    List<LineupItem> items = [];
    for (int i = 0; i < membersCount; i++) {
      int pos = start + i;
      items.add(LineupItem(
        'Player $pos',
        pos,
        pos,
        pos == 5,
        pos > 8,
        Random().nextInt(9) + Random().nextDouble(),
        local ? _localImages[pos - 1] : _visitorImages[pos - 1],
      ));
    }

    return ParsedTeamLineupLine(items);
  }
}
