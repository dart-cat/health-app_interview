import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vstrecha/data/models/hotline.dart';
import 'package:vstrecha/data/repositories/hotlines_repository.dart';

part 'hotlines_event.dart';
part 'hotlines_state.dart';

class HotlinesBloc extends Bloc<HotlinesEvent, HotlinesState> {
  HotlinesBloc() : super(HotlinesInitial()) {
    HotlinesRepository.instance.init();

    on<LoadHotlinesEvent>((event, emit) async {
      emit(HotlinesLoading());
      final hotlines = await HotlinesRepository.instance.getHotlines();
      emit(HotlinesLoaded(hotlines: hotlines));
    });

    on<SearchHotlinesEvent>((event, emit) {
      final s = state as HotlinesLoaded;
      emit(HotlinesLoading());

      final results = s.hotlines
          .where(
            (e) => e.type_help_id.name.toLowerCase().contains(event.query.toLowerCase()),
          )
          .toList();

      emit(HotlinesSearch(
        query: event.query,
        hotlines: s.hotlines,
        results: results,
      ));
    });
  }
}
