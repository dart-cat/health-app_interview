part of 'analysis_bloc.dart';

abstract class AnalysisState extends Equatable {
  const AnalysisState();

  @override
  List<Object> get props => [];
}

class AnalysisInitial extends AnalysisState {}

class AnalysisLoading extends AnalysisState {}

class AnalysisLoaded extends AnalysisState {
  final SortOrder order;
  final List<AnalysisItem> images;

  const AnalysisLoaded({
    required this.images,
    this.order = SortOrder.descending,
  });
}

class AnalysisError extends AnalysisState {
  final String errorMessage;

  const AnalysisError({required this.errorMessage});
}
