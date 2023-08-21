part of 'hotlines_bloc.dart';

abstract class HotlinesState extends Equatable {
  const HotlinesState();

  @override
  List<Object> get props => [];
}

class HotlinesInitial extends HotlinesState {}

class HotlinesLoading extends HotlinesState {}

class HotlinesLoaded extends HotlinesState {
  final List<Hotline> hotlines;

  const HotlinesLoaded({required this.hotlines});
}

class HotlinesSearch extends HotlinesLoaded {
  final String query;
  final List<Hotline> results;

  const HotlinesSearch({
    required this.query,
    required this.results,
    required super.hotlines,
  });
}

class HotlinesError extends HotlinesState {
  final String errorMessage;

  const HotlinesError({required this.errorMessage});
}
