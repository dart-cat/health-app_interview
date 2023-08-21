part of 'institutions_bloc.dart';

abstract class InstitutionsState extends Equatable {
  const InstitutionsState();

  @override
  List<Object> get props => [];
}

class InstitutionsInitial extends InstitutionsState {}

class InstitutionsLoading extends InstitutionsState {}

class InstitutionsLoaded extends InstitutionsState {
  final List<Institution> institutions;
  final List<Institution>? searchResults;
  final int? currentIndex;
  final Filter filter;
  final bool abroad;

  const InstitutionsLoaded({
    required this.institutions,
    this.searchResults,
    this.currentIndex,
    this.filter = const Filter(),
    this.abroad = false,
  });
}

class InstitutionsError extends InstitutionsState {
  final String errorMessage;

  const InstitutionsError({required this.errorMessage});
}
