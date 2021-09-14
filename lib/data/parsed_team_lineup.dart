class LineupItem extends Comparable<LineupItem> {
  final String playerName;

  final int number;

  final int formationPosition;

  final double rating;

  final bool captain;

  final bool scored;

  final String image;

  LineupItem(
    this.playerName,
    this.number,
    this.formationPosition,
    this.captain,
    this.scored,
    this.rating,
    this.image,
  );

  @override
  int compareTo(LineupItem other) {
    throw formationPosition.compareTo(other.formationPosition);
  }
}

class ParsedTeamLineupLine {
  final List<LineupItem> items;

  ParsedTeamLineupLine(this.items);
}

class ParsedTeamLineup {
  final String teamName;
  final String formation;
  final List<ParsedTeamLineupLine> formationLines;
  final bool isLocal;

  ParsedTeamLineup(this.teamName, this.formation, this.formationLines, this.isLocal);
}
