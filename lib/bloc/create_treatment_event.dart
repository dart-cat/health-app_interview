part of 'create_treatment_bloc.dart';

abstract class CreateTreatmentEvent extends Equatable {
  const CreateTreatmentEvent();

  @override
  List<Object> get props => [];
}

class LoadCreateTreatment extends CreateTreatmentEvent {
  final TreatmentItem? item;

  const LoadCreateTreatment({this.item});
}

class SetTreatmentTitle extends CreateTreatmentEvent {
  final String title;

  const SetTreatmentTitle({required this.title});
}

class SetTreatmentStartDate extends CreateTreatmentEvent {
  final DateTime startDate;

  const SetTreatmentStartDate({required this.startDate});
}

class SetTreatmentEndDate extends CreateTreatmentEvent {
  final DateTime endDate;

  const SetTreatmentEndDate({required this.endDate});
}

class SetTreatmentFrequency extends CreateTreatmentEvent {
  final Frequency frequency;

  const SetTreatmentFrequency({required this.frequency});
}

class SetTreatmentTimes extends CreateTreatmentEvent {
  final List<DateTime> times;

  const SetTreatmentTimes({required this.times});
}

class SetTreatmentRemindBefore extends CreateTreatmentEvent {
  final Duration remindBefore;

  const SetTreatmentRemindBefore({required this.remindBefore});
}
