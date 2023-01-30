class TVShowModel {
  final int id;
  final String name;
  final String imageUrl;
  final Iterable<String> genres;
  final String summary;
  final String scheduledTime;

  TVShowModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.genres,
    required this.summary,
    required this.scheduledTime,
  });

  factory TVShowModel.fromMap(dynamic map) {
    final map_ = map['show'] ?? map;
    return TVShowModel(
      name: map_['name'] as String,
      imageUrl: map_['image'] != null
          ? map_['image']['original'] as String
          : 'https://media.istockphoto.com/id/1147544807/pt/vetorial/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=yQW3zPovyK7AFC4uApkbb5fiopWQeU1PiIRuDublNZ4=',
      id: map_['id'],
      scheduledTime: map_['schedule']['time'] +
          ' ' +
          (map_['schedule']['days'].isNotEmpty
              ? map_['schedule']['days'][0]
              : ''),
      genres: (map_['genres'] as List).map((e) => e.toString()),
      summary: map_['summary'],
    );
  }
}

class TVShowEpisodeModel {
  final int id;
  final String name;
  final int number;
  final int season;
  final String summary;
  final String imageUrl;

  TVShowEpisodeModel({
    required this.id,
    required this.name,
    required this.number,
    required this.season,
    required this.summary,
    required this.imageUrl,
  });

  factory TVShowEpisodeModel.fromMap(dynamic map) {
    return TVShowEpisodeModel(
      id: map['id'] as int,
      name: map['name'] as String,
      number: map['number'] as int,
      season: map['season'] as int,
      summary: map['summary'] != null ? map['summary'] as String : 'No summary',
      imageUrl: map['image'] != null
          ? map['image']['original'] as String
          : 'https://media.istockphoto.com/id/1147544807/pt/vetorial/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=yQW3zPovyK7AFC4uApkbb5fiopWQeU1PiIRuDublNZ4=',
    );
  }
}
