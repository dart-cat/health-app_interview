part of 'hotlines_bloc.dart';

abstract class HotlinesEvent extends Equatable {
  const HotlinesEvent();

  @override
  List<Object> get props => [];
}

class LoadHotlinesEvent extends HotlinesEvent {}

class SearchHotlinesEvent extends HotlinesEvent {
  final String query;

  const SearchHotlinesEvent({required this.query});
}
