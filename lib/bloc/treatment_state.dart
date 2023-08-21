part of 'treatment_bloc.dart';

abstract class TreatmentState extends Equatable {
  const TreatmentState();

  @override
  List<Object> get props => [];
}

class TreatmentInitial extends TreatmentState {}

class TreatmentLoading extends TreatmentState {}

class TreatmentLoaded extends TreatmentState {
  final List<TreatmentItem> treatmentItems;

  const TreatmentLoaded({required this.treatmentItems});
}

class TreatmentError extends TreatmentState {
  final String errorMessage;

  const TreatmentError({required this.errorMessage});
}
