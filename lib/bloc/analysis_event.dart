part of 'analysis_bloc.dart';

abstract class AnalysisEvent extends Equatable {
  const AnalysisEvent();

  @override
  List<Object> get props => [];
}

class LoadAnalysis extends AnalysisEvent {}

enum SortOrder {
  ascending,
  descending,
}

class SortAnalysis extends AnalysisEvent {
  final SortOrder order;

  const SortAnalysis({required this.order});
}

class AddAnalysis extends AnalysisEvent {
  final AnalysisItem item;

  const AddAnalysis({required this.item});
}

class RemoveAnalysis extends AnalysisEvent {
  final AnalysisItem item;

  const RemoveAnalysis({required this.item});
}
