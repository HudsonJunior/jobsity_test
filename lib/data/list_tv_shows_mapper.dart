import 'package:jobsity_test/data/model/tv_show_model.dart';
import 'package:jobsity_test/domain/model/show_entity.dart';

class ListTVShowsMapper {
  static ShowEntity modelToEntity(TVShowModel model) => ShowEntity(
        name: model.name,
        imageUrl: model.imageUrl,
        genres: model.genres,
        id: model.id,
        summary: model.summary,
        scheduledTime: model.scheduledTime,
      );

  static TVShowEpisodeEntity episodeModelToEntity(TVShowEpisodeModel model) =>
      TVShowEpisodeEntity(
        id: model.id,
        name: model.name,
        number: model.number,
        season: model.season,
        summary: model.summary,
        imageUrl: model.imageUrl,
      );
}
