import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_test/domain/use_case/list_show_episodes_use_case.dart';
import 'package:jobsity_test/view/list_shows_view_mapper.dart';
import 'package:jobsity_test/view/model/tv_show_episode_view_model.dart';

abstract class TVShowEpisodesState {}

class TVShowEpisodesIdleState implements TVShowEpisodesState {}

class TVShowEpisodesLoadingState implements TVShowEpisodesState {}

class TVShowEpisodesFailedState implements TVShowEpisodesState {
  final String error;

  TVShowEpisodesFailedState(this.error);
}

class TVShowEpisodesSuccessState implements TVShowEpisodesState {
  final Map<int, List<TVShowEpisodeViewModel>> shows;

  TVShowEpisodesSuccessState(this.shows);
}

class TVShowEpisodesBloc extends Cubit<TVShowEpisodesState> {
  TVShowEpisodesBloc(
    this.tvShowEpisodesUseCase,
  ) : super(TVShowEpisodesIdleState());

  final ListTVShowEpisodesUseCase tvShowEpisodesUseCase;

  void getTvShowEpisodes(int id) async {
    emit(TVShowEpisodesLoadingState());

    final result = await tvShowEpisodesUseCase(id);

    if (result.isSuccess) {
      final listConverted = result.asSuccess.data
          .map(ListTVShowsViewMapper.episodesEntityToViewModel);

      final listBuilded = TvShowEpisodesBuilder.buildSeasons(listConverted);

      emit(TVShowEpisodesSuccessState(listBuilded));
    } else {
      emit(TVShowEpisodesFailedState(result.asFailure.failure.message));
    }
  }
}

class TvShowEpisodesBuilder {
  static Map<int, List<TVShowEpisodeViewModel>> buildSeasons(
    Iterable<TVShowEpisodeViewModel> list,
  ) {
    final seasons = <int, List<TVShowEpisodeViewModel>>{};

    for (var element in list) {
      seasons.update(
        element.season,
        (value) => value..add(element),
        ifAbsent: () => [element],
      );
    }

    return seasons;
  }
}
