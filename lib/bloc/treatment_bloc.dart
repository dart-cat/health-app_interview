import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:vstrecha/data/models/treatment.dart';
import 'package:vstrecha/data/repositories/events_repository.dart';

part 'treatment_event.dart';
part 'treatment_state.dart';

class TreatmentBloc extends Bloc<TreatmentEvent, TreatmentState> {
  TreatmentBloc() : super(TreatmentInitial()) {
    EventsRepository.instance.init();

    on<LoadTreatment>((event, emit) async {
      emit(TreatmentLoading());
      final treatmentItems = await EventsRepository.instance.getTreatmentRegimen();
      await _reapplyNotifications(treatmentItems);
      emit(TreatmentLoaded(treatmentItems: treatmentItems));
    });

    on<AddTreatment>((event, emit) async {
      if (state is TreatmentLoaded) {
        emit(TreatmentLoading());
        final newItems = await EventsRepository.instance.addTreatment(event.treatment);
        await _reapplyNotifications(newItems);
        emit(TreatmentLoaded(treatmentItems: newItems));
      }
    });

    on<RemoveTreatment>((event, emit) async {
      if (state is TreatmentLoaded) {
        emit(TreatmentLoading());
        final newItems = await EventsRepository.instance.deleteTreatment(event.treatment);
        await _reapplyNotifications(newItems);
        emit(TreatmentLoaded(treatmentItems: newItems));
      }
    });

    on<UpdateTreatment>((event, emit) async {
      if (state is TreatmentLoaded) {
        emit(TreatmentLoading());
        final newItems = await EventsRepository.instance.updateTreatment(event.newItem, event.oldItem);
        await _reapplyNotifications(newItems);
        emit(TreatmentLoaded(treatmentItems: newItems));
      }
    });
  }

  Future<void> _reapplyNotifications(List<TreatmentItem> items) async {
    final String channelName = 'treatment-channel-name'.i18n();
    final String channelDescription = 'treatment-channel-description'.i18n();

    // Remove all event notifications
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.cancelAll();

    // Get events for next 30 days
    final now = DateTime.now();
    DateTime day = DateTime(now.year, now.month, now.day);

    const limit = 64;
    int setNotifications = 0;

    for (int i = 0; i < 30; i++) {
      List<TreatmentItem> todayItems = _getTodayItems(items, day);
      todayItems.sort((a, b) => a.times.first.compareTo(b.times.first));

      for (final event in todayItems) {
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
              setNotifications + 100, // Offset notification IDs to avoid conflicts with calendar events
              event.title,
              null,
              notificationTime,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  'by.HealthNavigator.Plus.Treatment',
                  channelName,
                  channelDescription: channelDescription,
                ),
              ),
              androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
              uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
            );

            debugPrint(
                'Scheduled notification "${event.title}" at ${DateFormat('dd.MM.yyyy HH:mm').format(notificationTime)}');

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

  List<TreatmentItem> _getTodayItems(
    List<TreatmentItem> items,
    DateTime? date,
  ) {
    final List<TreatmentItem> todayItems = [];
    for (var e in items) {
      switch (e.frequency) {
        case Frequency.daily:
          final now = date ?? DateTime.now();
          if (e.startDate!.compareTo(now) <= 0 && e.endDate!.compareTo(now) >= 0) {
            todayItems.add(e);
          }
          break;
        case Frequency.once:
          final now = date ?? DateTime.now();
          if (e.startDate!.year == now.year &&
              e.startDate!.month == now.month &&
              e.startDate!.day == now.day) {
            todayItems.add(e);
          }
          break;
        case Frequency.onceAWeek:
          final now = date ?? DateTime.now();
          if (e.startDate!.compareTo(now) <= 0 &&
              e.endDate!.compareTo(now) >= 0 &&
              now.difference(e.startDate!).inDays % 7 == 0) {
            todayItems.add(e);
          }
          break;
        case Frequency.onceAMonth:
          final now = date ?? DateTime.now();
          if (e.startDate!.compareTo(now) <= 0 &&
              e.endDate!.compareTo(now) >= 0 &&
              now.difference(e.startDate!).inDays % 30 == 0) {
            todayItems.add(e);
          }
          break;
        case Frequency.everyFewDays:
        default:
          break;
      }
    }
    todayItems.sort((a, b) => a.times.first.compareTo(b.times.first));
    return todayItems;
  }
}
