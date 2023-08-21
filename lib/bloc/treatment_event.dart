part of 'treatment_bloc.dart';

abstract class TreatmentEvent extends Equatable {
  const TreatmentEvent();

  @override
  List<Object> get props => [];
}

class LoadTreatment extends TreatmentEvent {}

class AddTreatment extends TreatmentEvent {
  final TreatmentItem treatment;

  const AddTreatment({required this.treatment});
}

class RemoveTreatment extends TreatmentEvent {
  final TreatmentItem treatment;

  const RemoveTreatment({required this.treatment});
}

class UpdateTreatment extends TreatmentEvent {
  final TreatmentItem oldItem;
  final TreatmentItem newItem;

  const UpdateTreatment({
    required this.oldItem,
    required this.newItem,
  });
}
