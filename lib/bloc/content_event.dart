part of 'content_bloc.dart';

abstract class ContentEvent extends Equatable {
  const ContentEvent();

  @override
  List<Object> get props => [];
}

class LoadSectionsEvent extends ContentEvent {}

class LoadArticlesEvent extends ContentEvent {
  final int id;

  const LoadArticlesEvent({required this.id});
}

class LoadContentEvent extends ContentEvent {
  final int id;

  const LoadContentEvent({required this.id});
}
