import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:vstrecha/data/models/article.dart';
import 'package:vstrecha/data/models/library_section.dart';
import 'package:vstrecha/data/repositories/content_repository.dart';

part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  ContentBloc() : super(ContentInitial()) {
    ContentRepository.instance.init();

    on<LoadSectionsEvent>((event, emit) async {
      emit(SectionsLoading());
      final sections = await ContentRepository.instance.getSections();
      emit(SectionsLoaded(children: sections));
    });

    on<LoadArticlesEvent>((event, emit) async {
      if (state is SectionsLoaded) {
        final s = state as SectionsLoaded;
        emit(ArticlesLoading(
          id: event.id,
          name: s.children.where((e) => e.id == event.id).first.name,
        ));
        final articles = await ContentRepository.instance.getArticles(event.id);
        emit(ArticlesLoaded(
          id: event.id,
          name: s.children.where((e) => e.id == event.id).first.name,
          articles: articles,
        ));
      }
    });

    on<LoadContentEvent>((event, emit) {
      if (state is ArticlesLoaded) {
        final s = state as ArticlesLoaded;
        final article = s.articles[event.id];
        emit(ContentLoading(
          title: article.title,
          articles: s.articles,
          id: s.id,
          name: s.name,
        ));
        emit(ContentLoaded(
          title: article.title,
          text: article.text,
          articles: s.articles,
          id: s.id,
          name: s.name,
        ));
      }
    });
  }
}
