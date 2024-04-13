class Lineup {
  final String lineupName;
  final String lineupDescription;
  final String lineupImageUrl;
  final String siteName;

  Lineup({
    required this.lineupName,
    required this.lineupDescription,
    required this.lineupImageUrl,
    required this.siteName,
  });

  factory Lineup.fromJson(Map<String, dynamic> json) {
    return Lineup(
      lineupName: json['lineupName'],
      lineupDescription: json['lineupDescription'],
      lineupImageUrl: json['lineupImageUrl'],
      siteName: json['siteName'],
    );
  }
}
