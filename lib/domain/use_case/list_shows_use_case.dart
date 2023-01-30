import 'package:jobsity_test/core/result.dart';
import 'package:jobsity_test/domain/model/show_entity.dart';
import 'package:jobsity_test/domain/repository/tv_shows_repository.dart';

abstract class ListTVShowsUseCase {
  Future<Result<Iterable<ShowEntity>>> call();
}

class ListTVShowsUseCaseImpl implements ListTVShowsUseCase {
  final TVShowsRepository listTVShowsRepository;

  ListTVShowsUseCaseImpl(this.listTVShowsRepository);

  @override
  Future<Result<Iterable<ShowEntity>>> call() =>
      listTVShowsRepository.getShows();
}
