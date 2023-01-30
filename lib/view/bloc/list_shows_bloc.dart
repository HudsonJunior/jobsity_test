import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_test/domain/use_case/list_filtered_shows_use_case.dart';
import 'package:jobsity_test/domain/use_case/list_shows_use_case.dart';
import 'package:jobsity_test/view/list_shows_view_mapper.dart';
import 'package:jobsity_test/view/model/list_shows_view_model.dart';

abstract class ListTVShowsState {}

class ListTVShowsIdleState implements ListTVShowsState {}

class ListTVShowsLoadingState implements ListTVShowsState {}

class ListTVShowsFailedState implements ListTVShowsState {
  final String error;

  ListTVShowsFailedState(this.error);
}

class ListTVShowsSuccessState implements ListTVShowsState {
  final Iterable<ListTVShowsViewModel> shows;

  ListTVShowsSuccessState(this.shows);
}

class ListTVShowsBloc extends Cubit<ListTVShowsState> {
  ListTVShowsBloc(
    this.listTVShowsUseCase,
    this.listFilteredShowsUseCase,
  ) : super(ListTVShowsIdleState());

  final ListTVShowsUseCase listTVShowsUseCase;
  final ListFilteredShowsUseCase listFilteredShowsUseCase;

  void getShows() async {
    emit(ListTVShowsLoadingState());

    final result = await listTVShowsUseCase();

    if (result.isSuccess) {
      emit(
        ListTVShowsSuccessState(
          result.asSuccess.data.map(ListTVShowsViewMapper.entityToViewModel),
        ),
      );
    } else {
      emit(ListTVShowsFailedState(result.asFailure.failure.message));
    }
  }

  void getFilteredShows(String name) async {
    emit(ListTVShowsLoadingState());

    final result = await listFilteredShowsUseCase(name);

    if (result.isSuccess) {
      emit(
        ListTVShowsSuccessState(
          result.asSuccess.data.map(ListTVShowsViewMapper.entityToViewModel),
        ),
      );
    } else {
      emit(ListTVShowsFailedState(result.asFailure.failure.message));
    }
  }
}
