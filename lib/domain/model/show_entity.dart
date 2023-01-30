class ShowEntity {
  final String name;
  final String imageUrl;
  final int id;
  final Iterable<String> genres;
  final String summary;
  final String scheduledTime;

  ShowEntity({
    required this.name,
    required this.imageUrl,
    required this.id,
    required this.genres,
    required this.summary,
    required this.scheduledTime,
  });
}

class TVShowEpisodeEntity {
  final int id;
  final String name;
  final int number;
  final int season;
  final String summary;
  final String imageUrl;

  TVShowEpisodeEntity({
    required this.id,
    required this.name,
    required this.number,
    required this.season,
    required this.summary,
    required this.imageUrl,
  });
}
