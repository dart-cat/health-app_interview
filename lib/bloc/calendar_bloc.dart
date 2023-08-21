import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:vstrecha/data/models/calendar_event.dart';
import 'package:vstrecha/data/repositories/events_repository.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarInitial()) {
    EventsRepository.instance.init();

    on<LoadCalendarEvents>((event, emit) async {
      final date = event.date;
      emit(CalendarLoading(date: date ?? DateTime.now()));

      final events = await EventsRepository.instance.getCalendarEvents();
      await _reapplyNotifications(events);

      emit(CalendarLoaded(
        date: date,
        events: events,
        todayEvents: getTodayEvents(events, null),
        dailyEvents: getTodayEvents(events, date),
      ));
    });

    on<AddCalendarEvent>((event, emit) async {
      if (state is CalendarLoaded) {
        final date = (state as CalendarLoaded).date;
        emit(CalendarLoading(date: date ?? DateTime.now()));

        final newEvents = await EventsRepository.instance.addCalendarEvent(event.event);
        await _reapplyNotifications(newEvents);

        emit(CalendarLoaded(
          date: date,
          events: newEvents,
          todayEvents: getTodayEvents(newEvents, null),
          dailyEvents: getTodayEvents(newEvents, date),
        ));
      }
    });

    on<RemoveCalendarEvent>((event, emit) async {
      if (state is CalendarLoaded) {
        final date = (state as CalendarLoaded).date;
        emit(CalendarLoading(date: date ?? DateTime.now()));

        final newEvents = await EventsRepository.instance.deleteCalendarEvent(event.event);
        await _reapplyNotifications(newEvents);

        emit(CalendarLoaded(
          date: date,
          events: newEvents,
          todayEvents: getTodayEvents(newEvents, null),
          dailyEvents: getTodayEvents(newEvents, date),
        ));
      }
    });

    on<UpdateCalendarEvent>((event, emit) async {
      if (state is CalendarLoaded) {
        final date = (state as CalendarLoaded).date;
        emit(CalendarLoading(date: date ?? DateTime.now()));

        final newEvents = await EventsRepository.instance.updateCalendarEvent(event.newEvent, event.oldEvent);
        await _reapplyNotifications(newEvents);

        emit(CalendarLoaded(
          date: date,
          events: newEvents,
          todayEvents: getTodayEvents(newEvents, null),
          dailyEvents: getTodayEvents(newEvents, date),
        ));
      }
    });
  }

  Future<void> _reapplyNotifications(List<CalendarEventItem> events) async {
    final String channelName = 'calendar-channel-name'.i18n();
    final String channelDescription = 'calendar-channel-description'.i18n();

    // Remove all event notifications
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.cancelAll();

    // Get events for next 30 days
    final now = DateTime.now();
    DateTime day = DateTime(now.year, now.month, now.day);

    const limit = 64;
    int setNotifications = 0;

    for (int i = 0; i < 30; i++) {
      List<CalendarEventItem> todayEvents = getTodayEvents(events, day);
      todayEvents.sort((a, b) => a.times.first.compareTo(b.times.first));

      for (final event in todayEvents) {
        for (final time in event.times) {
          tz.TZDateTime notificationTime = tz.TZDateTime.from(
            (event.remindBefore == null)
                ? DateTime(day.year, day.month, day.day, time.hour, time.minute)
                : DateTime(day.year, day.month, day.day, time.hour, time.minute)
                    .subtract(event.remindBefore!),
            tz.local,
          );

          // Schedule notification if time is in future
          if (notificationTime.isAfter(tz.TZDateTime.now(tz.local))) {
            await flutterLocalNotificationsPlugin.zonedSchedule(
              setNotifications,
              _titleToString(event.title),
              event.description,
              notificationTime,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  'by.HealthNavigator.Plus.Calendar',
                  channelName,
                  channelDescription: channelDescription,
                ),
              ),
              androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
              uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
            );

            debugPrint(
                'Scheduled notification "${_titleToString(event.title)}: ${event.description}" at ${DateFormat('dd.MM.yyyy HH:mm').format(notificationTime)}');

            // Set first 64 notifications (iOS limitation)
            setNotifications++;
            if (setNotifications >= limit) {
              return;
            }
          }
        }
      }

      // Next day
      day = day.add(const Duration(days: 1));
    }
  }

  String _titleToString(EventType title) {
    switch (title) {
      case EventType.appointment:
        return "appointment".i18n();
      case EventType.testing:
        return "testing".i18n();
      case EventType.therapy:
        return "therapy".i18n();
      case EventType.other:
        return "other".i18n();
    }
  }

  List<CalendarEventItem> getTodayEvents(
    List<CalendarEventItem> events,
    DateTime? date,
  ) {
    final List<CalendarEventItem> todayEvents = [];
    for (var e in events) {
      switch (e.frequency) {
        case Frequency.daily:
          final now = date ?? DateTime.now();
          if (e.startDate!.compareTo(now) <= 0 && e.endDate!.compareTo(now) >= 0) {
            todayEvents.add(e);
          }
          break;
        case Frequency.once:
          final now = date ?? DateTime.now();
          if (e.startDate!.year == now.year &&
              e.startDate!.month == now.month &&
              e.startDate!.day == now.day) {
            todayEvents.add(e);
          }
          break;
        case Frequency.onceAWeek:
          final now = date ?? DateTime.now();
          if (e.startDate!.compareTo(now) <= 0 &&
              e.endDate!.compareTo(now) >= 0 &&
              now.difference(e.startDate!).inDays % 7 == 0) {
            todayEvents.add(e);
          }
          break;
        case Frequency.onceAMonth:
          final now = date ?? DateTime.now();
          if (e.startDate!.compareTo(now) <= 0 &&
              e.endDate!.compareTo(now) >= 0 &&
              now.difference(e.startDate!).inDays % 30 == 0) {
            todayEvents.add(e);
          }
          break;
        case Frequency.everyFewDays:
        default:
          break;
      }
    }
    todayEvents.sort((a, b) => a.times.first.compareTo(b.times.first));
    return todayEvents;
  }
}
