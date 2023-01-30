import 'package:jobsity_test/core/result.dart';
import 'package:jobsity_test/domain/model/show_entity.dart';
import 'package:jobsity_test/domain/repository/tv_shows_repository.dart';

abstract class ListFilteredShowsUseCase {
  Future<Result<Iterable<ShowEntity>>> call(String name);
}

class ListFilteredShowsUseCaseImpl implements ListFilteredShowsUseCase {
  final TVShowsRepository listTVShowsRepository;

  ListFilteredShowsUseCaseImpl(this.listTVShowsRepository);

  @override
  Future<Result<Iterable<ShowEntity>>> call(String name) =>
      listTVShowsRepository.getFilteredShows(name);
}
