import 'package:dio/dio.dart';
import 'package:jobsity_test/core/api.dart';
import 'package:jobsity_test/data/list_tv_shows_exceptions.dart';
import 'package:jobsity_test/data/model/tv_show_model.dart';

abstract class TVShowsDataSource {
  Future<Iterable<TVShowModel>> getShows();
  Future<Iterable<TVShowModel>> getFilteredShows(String name);
  Future<Iterable<TVShowEpisodeModel>> getTVShowEpisodes(int id);
}

class TVShowsDataSourceImpl implements TVShowsDataSource {
  final RestApi<Response> api;

  TVShowsDataSourceImpl(this.api);

  @override
  Future<Iterable<TVShowModel>> getShows() async {
    try {
      final response = await api.get('/shows', queryParameters: {
        'page': 1,
      });

      return (response.data as List).map(TVShowModel.fromMap);
    } on DioError {
      throw TVShowsException('Error listing TV shows from the network.');
    }
  }

  @override
  Future<Iterable<TVShowModel>> getFilteredShows(String name) async {
    try {
      final response = await api.get('search/shows', queryParameters: {
        'q': name,
      });

      return (response.data as List).map(TVShowModel.fromMap);
    } on DioError {
      throw TVShowsException('Error listing TV shows from the network.');
    }
  }

  @override
  Future<Iterable<TVShowEpisodeModel>> getTVShowEpisodes(int id) async {
    try {
      final response = await api.get('/shows/$id/episodes');

      return (response.data as List).map(TVShowEpisodeModel.fromMap);
    } on DioError catch (e) {
      throw TVShowsException('Error listing the TV show episodes list.');
    }
  }
}
