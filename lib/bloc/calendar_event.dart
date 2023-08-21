part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class LoadCalendarEvents extends CalendarEvent {
  final DateTime? date;

  const LoadCalendarEvents({this.date});
}

class AddCalendarEvent extends CalendarEvent {
  final CalendarEventItem event;

  const AddCalendarEvent({required this.event});
}

class RemoveCalendarEvent extends CalendarEvent {
  final CalendarEventItem event;

  const RemoveCalendarEvent({required this.event});
}

class UpdateCalendarEvent extends CalendarEvent {
  final CalendarEventItem oldEvent;
  final CalendarEventItem newEvent;

  const UpdateCalendarEvent({
    required this.oldEvent,
    required this.newEvent,
  });
}
