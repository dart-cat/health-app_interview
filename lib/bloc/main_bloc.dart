import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final Map<String, Widget> paths;

  MainBloc({required this.paths}) : super(MainInitial()) {
    on<LoadMainEvent>((event, emit) {
      emit(MainLoading());
      if (paths.containsKey('/')) {
        emit(MainLoaded(
          page: paths['/']!,
          history: const [Tuple2('/', 0)],
        ));
      } else {
        emit(const MainError('Error: route "/" not found'));
      }
    });

    on<ReplacePageEvent>((event, emit) {
      MainLoaded s = state as MainLoaded;
      int index = event.currentIndex ?? s.currentIndex;
      emit(MainLoading());
      emit(MainLoaded(
        history: [
          event.path != null ? Tuple2(event.path!, index) : s.history.last
        ],
        page: paths[event.path] ?? s.page,
        currentIndex: index,
        enableBackground: event.enableBackground ?? true,
        enableHeader: event.enableHeader ?? true,
        enableNavbar: event.enableNavbar ?? true,
      ));
    });

    on<PushPageEvent>((event, emit) {
      MainLoaded s = state as MainLoaded;
      int index = event.currentIndex ?? s.currentIndex;
      emit(MainLoading());
      emit(MainLoaded(
        history: event.path != null
            ? [...s.history, Tuple2(event.path!, index)]
            : s.history,
        page: paths[event.path] ?? s.page,
        currentIndex: index,
        enableBackground: event.enableBackground ?? true,
        enableHeader: event.enableHeader ?? true,
        enableNavbar: event.enableNavbar ?? true,
      ));
    });

    on<PopPageEvent>((event, emit) {
      MainLoaded s = state as MainLoaded;
      List<Tuple2<String, int>> newHistory =
          s.history.sublist(0, s.history.length - 1);
      emit(MainLoading());
      emit(MainLoaded(
        history: newHistory,
        page: paths[newHistory.last.item1]!,
        currentIndex: newHistory.last.item2,
      ));
    });
  }
}
