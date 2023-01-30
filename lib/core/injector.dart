import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jobsity_test/core/api.dart';
import 'package:jobsity_test/data/data_source/tv_shows_data_source.dart';
import 'package:jobsity_test/data/repository/tv_shows_repository.dart';
import 'package:jobsity_test/domain/repository/tv_shows_repository.dart';
import 'package:jobsity_test/domain/use_case/list_filtered_shows_use_case.dart';
import 'package:jobsity_test/domain/use_case/list_show_episodes_use_case.dart';
import 'package:jobsity_test/domain/use_case/list_shows_use_case.dart';

final GetIt serviceLocator = GetIt.I;

class Injector {
  static void inject() {
    serviceLocator.registerSingleton<RestApi<Response>>(RestApiImpl());

    serviceLocator.registerFactory<TVShowsDataSource>(
      () => TVShowsDataSourceImpl(serviceLocator()),
    );

    serviceLocator.registerFactory<TVShowsRepository>(
      () => TVShowsRepositoryImpl(serviceLocator()),
    );

    serviceLocator.registerFactory<ListTVShowsUseCase>(
      () => ListTVShowsUseCaseImpl(serviceLocator()),
    );

    serviceLocator.registerFactory<ListFilteredShowsUseCase>(
      () => ListFilteredShowsUseCaseImpl(serviceLocator()),
    );

    serviceLocator.registerFactory<ListTVShowEpisodesUseCase>(
      () => ListTVShowEpisodesUseCaseImpl(serviceLocator()),
    );
  }
}
