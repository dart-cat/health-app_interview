part of 'create_event_bloc.dart';

abstract class CreateEventState extends Equatable {
  const CreateEventState();

  @override
  List<Object> get props => [];
}

class CreateEventInitial extends CreateEventState {}

class CreateEventLoading extends CreateEventState {}

class CreateEventLoaded extends CreateEventState {
  final EventType title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final Frequency frequency;
  final List<DateTime> times;
  final Duration remindBefore;
  final CalendarEventItem? event;

  const CreateEventLoaded({
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.frequency,
    required this.times,
    required this.remindBefore,
    this.event,
  });
}

class CreateEventError extends CreateEventState {
  final String errorMessage;

  const CreateEventError({required this.errorMessage});
}
