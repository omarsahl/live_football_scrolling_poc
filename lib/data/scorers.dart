final Scorers scorers = Scorers(
  ["Karim Benzema 13'", "Toni Kroos 27'"],
  ["Óscar Mingueza 80'"],
);

class Scorers {
  final List<String> localScorers;
  final List<String> visitorScorers;

  Scorers(this.localScorers, this.visitorScorers);
}
