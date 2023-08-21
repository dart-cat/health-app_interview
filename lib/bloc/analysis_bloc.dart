import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:vstrecha/data/models/analysis.dart';
import 'package:vstrecha/data/repositories/analyses_repository.dart';

part 'analysis_event.dart';
part 'analysis_state.dart';

class AnalysisBloc extends Bloc<AnalysisEvent, AnalysisState> {
  AnalysisBloc() : super(AnalysisInitial()) {
    AnalysesRepository.instance.init();

    on<LoadAnalysis>((event, emit) async {
      // Save order and set loading state
      SortOrder order = state is AnalysisLoaded ? (state as AnalysisLoaded).order : SortOrder.descending;
      emit(AnalysisLoading());

      // Fetch images
      final images = await AnalysesRepository.instance.getAnalyses();

      // Sort using proper order
      images.sort((img1, img2) =>
          order == SortOrder.ascending ? img1.date.compareTo(img2.date) : img2.date.compareTo(img1.date));

      // Set new state
      emit(AnalysisLoaded(images: images));
    });

    on<AddAnalysis>((event, emit) async {
      // Save order and set loading state
      SortOrder order = (state as AnalysisLoaded).order;
      emit(AnalysisLoading());

      // Fetch new list
      List<AnalysisItem>? images = await AnalysesRepository.instance.addAnalysis(event.item);

      // Sort using proper order
      images.sort((img1, img2) =>
          order == SortOrder.ascending ? img1.date.compareTo(img2.date) : img2.date.compareTo(img1.date));

      // Set new state
      emit(AnalysisLoaded(images: images));
    });

    on<RemoveAnalysis>((event, emit) async {
      emit(AnalysisLoading());
      List<AnalysisItem>? images = await AnalysesRepository.instance.removeAnalysis(event.item);
      emit(AnalysisLoaded(images: images));
    });

    on<SortAnalysis>((event, emit) {
      List<AnalysisItem> images = state is AnalysisLoaded ? [...(state as AnalysisLoaded).images] : [];
      emit(AnalysisLoading());

      images.sort((img1, img2) => event.order == SortOrder.ascending
          ? img1.date.compareTo(img2.date)
          : img2.date.compareTo(img1.date));

      emit(AnalysisLoaded(images: images, order: event.order));
    });
  }
}
