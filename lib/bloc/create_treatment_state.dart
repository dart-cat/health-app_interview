part of 'create_treatment_bloc.dart';

abstract class CreateTreatmentState extends Equatable {
  const CreateTreatmentState();

  @override
  List<Object> get props => [];
}

class CreateTreatmentInitial extends CreateTreatmentState {}

class CreateTreatmentLoading extends CreateTreatmentState {}

class CreateTreatmentLoaded extends CreateTreatmentState {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final Frequency frequency;
  final List<DateTime> times;
  final Duration remindBefore;
  final TreatmentItem? item;

  const CreateTreatmentLoaded({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.frequency,
    required this.times,
    required this.remindBefore,
    this.item,
  });
}

class CreateTreatmentError extends CreateTreatmentState {
  final String errorMessage;

  const CreateTreatmentError({required this.errorMessage});
}
