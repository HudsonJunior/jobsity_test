import 'package:jobsity_test/domain/model/show_entity.dart';
import 'package:jobsity_test/view/model/list_shows_view_model.dart';
import 'package:jobsity_test/view/model/tv_show_detailed_view_model.dart';
import 'package:jobsity_test/view/model/tv_show_episode_view_model.dart';

class ListTVShowsViewMapper {
  static ListTVShowsViewModel entityToViewModel(ShowEntity entity) =>
      ListTVShowsViewModel(
        name: entity.name,
        imageUrl: entity.imageUrl,
        id: entity.id,
        genres: entity.genres,
        summary: entity.summary,
        scheduledTime: entity.scheduledTime,
      );

  static TVShowDetailedModel listViewToDetailedView(
    ListTVShowsViewModel model,
  ) =>
      TVShowDetailedModel(
        name: model.name,
        imageUrl: model.imageUrl,
        id: model.id,
        genres: model.genres,
        summary: model.summary,
        scheduledTime: model.scheduledTime,
      );

  static TVShowEpisodeViewModel episodesEntityToViewModel(
    TVShowEpisodeEntity entity,
  ) =>
      TVShowEpisodeViewModel(
        id: entity.id,
        name: entity.name,
        number: entity.number,
        season: entity.season,
        summary: entity.summary,
        imageUrl: entity.imageUrl,
      );
}
