part of 'institutions_bloc.dart';

abstract class InstitutionsEvent extends Equatable {
  const InstitutionsEvent();

  @override
  List<Object> get props => [];
}

class LoadInstitutionsEvent extends InstitutionsEvent {}

class LoadInstitutionsAbroadEvent extends InstitutionsEvent {}

class DetailInstitutionEvent extends InstitutionsEvent {
  final int index;

  const DetailInstitutionEvent({required this.index});
}

class SearchInstitutionsEvent extends InstitutionsEvent {
  final String query;

  const SearchInstitutionsEvent({required this.query});
}

class FilterInstitutionsEvent extends InstitutionsEvent {
  final Filter filter;

  const FilterInstitutionsEvent({required this.filter});
}
