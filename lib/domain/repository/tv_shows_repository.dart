import 'package:jobsity_test/core/result.dart';
import 'package:jobsity_test/domain/model/show_entity.dart';

abstract class TVShowsRepository {
  Future<Result<Iterable<ShowEntity>>> getShows();
  Future<Result<Iterable<ShowEntity>>> getFilteredShows(String name);
  Future<Result<Iterable<TVShowEpisodeEntity>>> getTVShowEpisodes(int id);
}
