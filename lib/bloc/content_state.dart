part of 'content_bloc.dart';

abstract class ContentState extends Equatable {
  const ContentState();

  @override
  List<Object> get props => [];
}

class ContentInitial extends ContentState {}

class ContentError extends ContentState {
  final String errorMessage;

  const ContentError({required this.errorMessage});
}

class SectionsLoading extends ContentState {}

class SectionsLoaded extends ContentState {
  final List<LibrarySection> children;

  const SectionsLoaded({required this.children});
}

class ArticlesLoading extends ContentState {
  final int id;
  final String name;

  const ArticlesLoading({
    required this.id,
    required this.name,
  });
}

class ArticlesLoaded extends ContentState {
  final int id;
  final String name;
  final List<Article> articles;

  const ArticlesLoaded({
    required this.id,
    required this.name,
    required this.articles,
  });
}

class ContentLoading extends ArticlesLoaded {
  final String title;

  const ContentLoading({
    required this.title,
    required super.articles,
    required super.id,
    required super.name,
  });
}

class ContentLoaded extends ArticlesLoaded {
  final String title;
  final String text;

  const ContentLoaded({
    required this.title,
    required this.text,
    required super.articles,
    required super.id,
    required super.name,
  });
}
