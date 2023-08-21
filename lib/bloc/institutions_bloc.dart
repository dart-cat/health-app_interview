import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vstrecha/data/models/filter.dart';
import 'package:vstrecha/data/models/institution.dart';
import 'package:vstrecha/data/repositories/institutions_repository.dart';

part 'institutions_event.dart';
part 'institutions_state.dart';

class InstitutionsBloc extends Bloc<InstitutionsEvent, InstitutionsState> {
  InstitutionsBloc() : super(InstitutionsInitial()) {
    InstitutionsRepository.instance.init();

    on<LoadInstitutionsEvent>((event, emit) async {
      emit(InstitutionsLoading());
      final institutions =
          await InstitutionsRepository.instance.getInstitutions();
      emit(InstitutionsLoaded(institutions: institutions));
    });

    on<LoadInstitutionsAbroadEvent>((event, emit) async {
      emit(InstitutionsLoading());
      final institutions =
          await InstitutionsRepository.instance.getInstitutions(abroad: true);
      print('13213 $institutions');
      emit(InstitutionsLoaded(institutions: institutions, abroad: true));
    });

    on<DetailInstitutionEvent>((event, emit) {
      if (state is InstitutionsLoaded) {
        final institutions = (state as InstitutionsLoaded).institutions;
        final filter = (state as InstitutionsLoaded).filter;
        final abroad = (state as InstitutionsLoaded).abroad;
        final results = (state as InstitutionsLoaded).searchResults;
        print('Вот он я + ${event.index}');
        emit(InstitutionsLoading());
        emit(InstitutionsLoaded(
          searchResults: results,
          institutions: institutions,
          currentIndex: event.index,
          abroad: abroad,
          filter: filter,
        ));
      }
    });

    on<SearchInstitutionsEvent>((event, emit) {
      final institutions = (state as InstitutionsLoaded).institutions;
      final filter = (state as InstitutionsLoaded).filter;
      final abroad = (state as InstitutionsLoaded).abroad;
      emit(InstitutionsLoading());

      if (event.query.isEmpty) {
        emit(InstitutionsLoaded(institutions: institutions, abroad: abroad));
        return;
      }

      final results = institutions
          .where(
            (element) => element.name.contains(
              RegExp(
                event.query,
                caseSensitive: false,
              ),
            ),
          )
          .toList();

      print('ивент ${event.query}');
      print('результат ${results[0].city_id?.name}');

      emit(InstitutionsLoaded(
        institutions: institutions,
        searchResults: results,
        abroad: abroad,
        filter: filter,
      ));
    });

    on<FilterInstitutionsEvent>((event, emit) async {
      final abroad = (state as InstitutionsLoaded).abroad;
      emit(InstitutionsLoading());

      var institutions =
          await InstitutionsRepository.instance.getInstitutions(abroad: abroad);
      if (event.filter.city != null) {
        institutions = institutions
            .where((i) => i.city_id?.id == event.filter.city?.id)
            .toList();
      }
      if (event.filter.type != null) {
        institutions = institutions
            .where((i) => i.type_id.id == event.filter.type?.id)
            .toList();
      }

      emit(InstitutionsLoaded(
        institutions: institutions,
        filter: event.filter,
        abroad: abroad,
      ));
    });
  }
}
