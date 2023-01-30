import 'package:jobsity_test/core/result.dart';
import 'package:jobsity_test/data/data_source/tv_shows_data_source.dart';
import 'package:jobsity_test/data/list_tv_shows_exceptions.dart';
import 'package:jobsity_test/data/list_tv_shows_mapper.dart';
import 'package:jobsity_test/domain/model/show_entity.dart';
import 'package:jobsity_test/domain/repository/tv_shows_repository.dart';
import 'package:jobsity_test/domain/tv_shows_failure.dart';

class TVShowsRepositoryImpl implements TVShowsRepository {
  final TVShowsDataSource listTVShowsDataSouce;

  TVShowsRepositoryImpl(this.listTVShowsDataSouce);

  @override
  Future<Result<Iterable<ShowEntity>>> getShows() async {
    try {
      final data = await listTVShowsDataSouce.getShows();

      return Result.success(data.map(ListTVShowsMapper.modelToEntity));
    } on TVShowsException catch (e) {
      return Result.failure(TVShowsFailure(e.message));
    }
  }

  @override
  Future<Result<Iterable<ShowEntity>>> getFilteredShows(String name) async {
    try {
      final data = await listTVShowsDataSouce.getFilteredShows(name);

      return Result.success(data.map(ListTVShowsMapper.modelToEntity));
    } on TVShowsException catch (e) {
      return Result.failure(TVShowsFailure(e.message));
    }
  }

  @override
  Future<Result<Iterable<TVShowEpisodeEntity>>> getTVShowEpisodes(
      int id) async {
    try {
      final data = await listTVShowsDataSouce.getTVShowEpisodes(id);

      return Result.success(data.map(ListTVShowsMapper.episodeModelToEntity));
    } on TVShowsException catch (e) {
      return Result.failure(TVShowsFailure(e.message));
    }
  }
}
