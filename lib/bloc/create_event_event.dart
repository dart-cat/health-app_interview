part of 'create_event_bloc.dart';

abstract class CreateEventEvent extends Equatable {
  const CreateEventEvent();

  @override
  List<Object> get props => [];
}

class LoadCreateEvent extends CreateEventEvent {
  final CalendarEventItem? event;

  const LoadCreateEvent({this.event});
}

class SetEventTitle extends CreateEventEvent {
  final EventType title;

  const SetEventTitle({required this.title});
}

class SetEventDescription extends CreateEventEvent {
  final String description;

  const SetEventDescription({required this.description});
}

class SetEventStartDate extends CreateEventEvent {
  final DateTime startDate;

  const SetEventStartDate({required this.startDate});
}

class SetEventEndDate extends CreateEventEvent {
  final DateTime endDate;

  const SetEventEndDate({required this.endDate});
}

class SetEventFrequency extends CreateEventEvent {
  final Frequency frequency;

  const SetEventFrequency({required this.frequency});
}

class SetEventTimes extends CreateEventEvent {
  final List<DateTime> times;

  const SetEventTimes({required this.times});
}

class SetEventRemindBefore extends CreateEventEvent {
  final Duration remindBefore;

  const SetEventRemindBefore({required this.remindBefore});
}
