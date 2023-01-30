
class TVShowDetailedModel {
  final String name;
  final String imageUrl;
  final int id;
  final Iterable<String> genres;
  final String summary;
  final String scheduledTime;

  TVShowDetailedModel({
    required this.name,
    required this.imageUrl,
    required this.id,
    required this.genres,
    required this.summary,
    required this.scheduledTime,
  });
}
