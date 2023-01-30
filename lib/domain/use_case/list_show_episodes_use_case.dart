import 'package:jobsity_test/core/result.dart';
import 'package:jobsity_test/domain/model/show_entity.dart';
import 'package:jobsity_test/domain/repository/tv_shows_repository.dart';

abstract class ListTVShowEpisodesUseCase {
  Future<Result<Iterable<TVShowEpisodeEntity>>> call(int id);
}

class ListTVShowEpisodesUseCaseImpl implements ListTVShowEpisodesUseCase {
  final TVShowsRepository listTVShowsRepository;

  ListTVShowEpisodesUseCaseImpl(this.listTVShowsRepository);

  @override
  Future<Result<Iterable<TVShowEpisodeEntity>>> call(int id) =>
      listTVShowsRepository.getTVShowEpisodes(id);
}
