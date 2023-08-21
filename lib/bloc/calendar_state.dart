part of 'calendar_bloc.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object> get props => [];
}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {
  final DateTime? date;

  const CalendarLoading({this.date});
}

class CalendarLoaded extends CalendarState {
  final DateTime? date;
  final List<CalendarEventItem> events;
  final List<CalendarEventItem> todayEvents;
  final List<CalendarEventItem> dailyEvents;

  const CalendarLoaded({
    this.date,
    required this.events,
    required this.todayEvents,
    required this.dailyEvents,
  });
}

class CalendarError extends CalendarState {
  final DateTime date;
  final String errorMessage;

  const CalendarError({
    required this.date,
    required this.errorMessage,
  });
}
