import 'dart:io';

import 'package:dio/dio.dart';
import 'package:localization/localization.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:vstrecha/data/models/calendar_event.dart';
import 'package:vstrecha/data/models/treatment.dart' as treatment;
import 'package:vstrecha/data/providers/api.dart';
import 'package:vstrecha/data/providers/local_cache.dart';
import 'package:vstrecha/data/repositories/auth_repository.dart';

class EventsRepository {
  EventsRepository._privateConstructor();

  static final EventsRepository instance = EventsRepository._privateConstructor();

  late API api;
  late LocalCache cache;

  void init() {
    Dio dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    api = API(dio);
    cache = const LocalCache();
  }

  Future<List<CalendarEventItem>> getCalendarEvents() async {
    try {
      // Check internet connection
      final result = await InternetAddress.lookup('example.com').timeout(const Duration(seconds: 3));
      if (result.isEmpty || result[0].rawAddress.isEmpty) throw Exception('No internet');

      // Get user id
      final user = await AuthRepository.instance.getUser();
      if (user == null) throw Exception('Not authenticated');

      // Fetch and parse calendar event list
      final notifications = await api.getNotifications(user.id);
      final events = notifications.data.where((e) => e.event_type == 'CalendarEventItem').map((e) {
        return CalendarEventItem(
          id: e.id,
          title: e.event_name != null ? _titleToType(e.event_name!) : EventType.appointment,
          description: e.what_remind,
          startDate: e.date_start,
          endDate: e.date_completion,
          frequency: e.periodicity != null ? _freqFromString(e.periodicity!) : Frequency.once,
          times: e.time.split(',').map((t) => DateTime.parse(t)).toList(),
          remindBefore: Duration(minutes: int.parse(e.time_remind ?? "5")),
        );
      }).toList();

      // Save to cache and return results
      await cache.saveCalendarEvents(events);
      return events;
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      // Read cache if no internet connection
      return await cache.loadCalendarEvents();
    }
  }

  Future<List<treatment.TreatmentItem>> getTreatmentRegimen() async {
    try {
      // Check internet connection
      final result = await InternetAddress.lookup('example.com').timeout(const Duration(seconds: 3));
      if (result.isEmpty || result[0].rawAddress.isEmpty) throw Exception('No internet');

      // Get user id
      final user = await AuthRepository.instance.getUser();
      if (user == null) throw Exception('Not authenticated');

      // Fetch and parse calendar event list
      final notifications = await api.getNotifications(user.id);
      final events = notifications.data.where((e) => e.event_type == 'TreatmentItem').map((e) {
        return treatment.TreatmentItem(
          id: e.id,
          title: e.event_name ?? '',
          startDate: e.date_start,
          endDate: e.date_completion,
          frequency: e.periodicity != null ? _tfreqFromString(e.periodicity!) : null,
          times: e.time.split(',').map((t) => DateTime.parse(t)).toList(),
          remindBefore: Duration(minutes: int.parse(e.time_remind ?? "5")),
        );
      }).toList();

      // Save to cache and return results
      await cache.saveTreatmentRegimen(events);
      return events;
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      // Read cache if no internet connection
      return await cache.loadTreatmentRegimen();
    }
  }

  Future<List<CalendarEventItem>> addCalendarEvent(CalendarEventItem item) async {
    try {
      // Check internet connection
      final result = await InternetAddress.lookup('example.com').timeout(const Duration(seconds: 3));
      if (result.isEmpty || result[0].rawAddress.isEmpty) throw Exception('No internet');

      // Get user id
      final user = await AuthRepository.instance.getUser();
      if (user == null) throw Exception('Not authenticated');

      // Fetch and parse calendar event list
      var notifications = await api.getNotifications(user.id);
      var events = notifications.data.where((e) => e.event_type == 'CalendarEventItem').map((e) {
        return CalendarEventItem(
          id: e.id,
          title: e.event_name != null ? _titleToType(e.event_name!) : EventType.appointment,
          description: e.what_remind,
          startDate: e.date_start,
          endDate: e.date_completion,
          frequency: e.periodicity != null ? _freqFromString(e.periodicity!) : Frequency.once,
          times: e.time.split(',').map((t) => DateTime.parse(t)).toList(),
          remindBefore: Duration(minutes: int.parse(e.time_remind ?? '5')),
        );
      }).toList();

      // Add new item to the server
      await api.addNotification(
        user.id,
        'CalendarEventItem',
        _typeToTitle(item.title),
        item.description ?? '',
        item.startDate?.toIso8601String() ?? '',
        item.endDate?.toIso8601String() ?? '',
        item.frequency != null ? _freqToString(item.frequency!) : '',
        item.times.map((t) => t.toIso8601String()).join(','),
        '${item.remindBefore?.inMinutes ?? 5}',
      );

      // Fetch updated list from server
      notifications = await api.getNotifications(user.id);
      events = notifications.data.where((e) => e.event_type == 'CalendarEventItem').map((e) {
        return CalendarEventItem(
          id: e.id,
          title: e.event_name != null ? _titleToType(e.event_name!) : EventType.appointment,
          description: e.what_remind,
          startDate: e.date_start,
          endDate: e.date_completion,
          frequency: e.periodicity != null ? _freqFromString(e.periodicity!) : Frequency.once,
          times: e.time.split(',').map((t) => DateTime.parse(t)).toList(),
          remindBefore: Duration(minutes: int.parse(e.time_remind ?? '5')),
        );
      }).toList();

      // Update cache and return results
      await cache.saveCalendarEvents(events);
      return events;
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      // Read cache if no internet connection
      return await cache.loadCalendarEvents();
    }
  }

  Future<List<treatment.TreatmentItem>> addTreatment(treatment.TreatmentItem item) async {
    try {
      // Check internet connection
      final result = await InternetAddress.lookup('example.com').timeout(const Duration(seconds: 3));
      if (result.isEmpty || result[0].rawAddress.isEmpty) throw Exception('No internet');

      // Get user id
      final user = await AuthRepository.instance.getUser();
      if (user == null) throw Exception('Not authenticated');

      // Fetch and parse calendar event list
      var notifications = await api.getNotifications(user.id);
      var events = notifications.data.where((e) => e.event_type == 'TreatmentItem').map((e) {
        return treatment.TreatmentItem(
          id: e.id,
          title: e.event_name ?? '',
          startDate: e.date_start,
          endDate: e.date_completion,
          frequency: e.periodicity != null ? _tfreqFromString(e.periodicity!) : null,
          times: e.time.split(',').map((t) => DateTime.parse(t)).toList(),
          remindBefore: Duration(minutes: int.parse(e.time_remind ?? "5")),
        );
      }).toList();

      // Add new item to the server
      await api.addNotification(
        user.id,
        'TreatmentItem',
        item.title,
        '',
        item.startDate?.toIso8601String() ?? '',
        item.endDate?.toIso8601String() ?? '',
        item.frequency != null ? _tfreqToString(item.frequency!) : '',
        item.times.map((t) => t.toIso8601String()).join(','),
        '${item.remindBefore?.inMinutes ?? 5}',
      );

      // Fetch updated list from server
      notifications = await api.getNotifications(user.id);
      events = notifications.data.where((e) => e.event_type == 'TreatmentItem').map((e) {
        return treatment.TreatmentItem(
          id: e.id,
          title: e.event_name ?? '',
          startDate: e.date_start,
          endDate: e.date_completion,
          frequency: e.periodicity != null ? _tfreqFromString(e.periodicity!) : null,
          times: e.time.split(',').map((t) => DateTime.parse(t)).toList(),
          remindBefore: Duration(minutes: int.parse(e.time_remind ?? "5")),
        );
      }).toList();

      // Update cache and return results
      await cache.saveTreatmentRegimen(events);
      return events;
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      // Read cache if no internet connection
      return await cache.loadTreatmentRegimen();
    }
  }

  Future<List<CalendarEventItem>> updateCalendarEvent(
    CalendarEventItem newItem,
    CalendarEventItem oldItem,
  ) async {
    try {
      // Check internet connection
      final result = await InternetAddress.lookup('example.com').timeout(const Duration(seconds: 3));
      if (result.isEmpty || result[0].rawAddress.isEmpty) throw Exception('No internet');

      // Get user id
      final user = await AuthRepository.instance.getUser();
      if (user == null) throw Exception('Not authenticated');

      // Fetch and parse calendar event list
      var notifications = await api.getNotifications(user.id);
      var events = notifications.data.where((e) => e.event_type == 'CalendarEventItem').map((e) {
        return CalendarEventItem(
          id: e.id,
          title: e.event_name != null ? _titleToType(e.event_name!) : EventType.appointment,
          description: e.what_remind,
          startDate: e.date_start,
          endDate: e.date_completion,
          frequency: e.periodicity != null ? _freqFromString(e.periodicity!) : Frequency.once,
          times: e.time.split(',').map((t) => DateTime.parse(t)).toList(),
          remindBefore: Duration(minutes: int.parse(e.time_remind ?? '5')),
        );
      }).toList();

      // Send delete request to the server
      events = events.where((e) => e.id != oldItem.id).toList();
      if (oldItem.id != null) await api.deleteNotification(oldItem.id!);

      // Add new item to the server
      await api.addNotification(
        user.id,
        'CalendarEventItem',
        _typeToTitle(newItem.title),
        newItem.description ?? '',
        newItem.startDate?.toIso8601String() ?? '',
        newItem.endDate?.toIso8601String() ?? '',
        newItem.frequency != null ? _freqToString(newItem.frequency!) : '',
        newItem.times.map((t) => t.toIso8601String()).join(','),
        '${newItem.remindBefore?.inMinutes ?? 5}',
      );

      // Fetch updated list from server
      notifications = await api.getNotifications(user.id);
      events = notifications.data.where((e) => e.event_type == 'CalendarEventItem').map((e) {
        return CalendarEventItem(
          id: e.id,
          title: e.event_name != null ? _titleToType(e.event_name!) : EventType.appointment,
          description: e.what_remind,
          startDate: e.date_start,
          endDate: e.date_completion,
          frequency: e.periodicity != null ? _freqFromString(e.periodicity!) : Frequency.once,
          times: e.time.split(',').map((t) => DateTime.parse(t)).toList(),
          remindBefore: Duration(minutes: int.parse(e.time_remind ?? '5')),
        );
      }).toList();

      // Update cache and return results
      await cache.saveCalendarEvents(events);
      return events;
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      // Read cache if no internet connection
      return await cache.loadCalendarEvents();
    }
  }

  Future<List<treatment.TreatmentItem>> updateTreatment(
    treatment.TreatmentItem newItem,
    treatment.TreatmentItem oldItem,
  ) async {
    try {
      // Check internet connection
      final result = await InternetAddress.lookup('example.com').timeout(const Duration(seconds: 3));
      if (result.isEmpty || result[0].rawAddress.isEmpty) throw Exception('No internet');

      // Get user id
      final user = await AuthRepository.instance.getUser();
      if (user == null) throw Exception('Not authenticated');

      // Fetch and parse calendar event list
      var notifications = await api.getNotifications(user.id);
      var events = notifications.data.where((e) => e.event_type == 'TreatmentItem').map((e) {
        return treatment.TreatmentItem(
          id: e.id,
          title: e.event_name ?? '',
          startDate: e.date_start,
          endDate: e.date_completion,
          frequency: e.periodicity != null ? _tfreqFromString(e.periodicity!) : null,
          times: e.time.split(',').map((t) => DateTime.parse(t)).toList(),
          remindBefore: Duration(minutes: int.parse(e.time_remind ?? "5")),
        );
      }).toList();

      // Delete item and send delete request to the server
      if (oldItem.id != null) await api.deleteNotification(oldItem.id!);

      // Add new item to the server
      await api.addNotification(
        user.id,
        'TreatmentItem',
        newItem.title,
        '',
        newItem.startDate?.toIso8601String() ?? '',
        newItem.endDate?.toIso8601String() ?? '',
        newItem.frequency != null ? _tfreqToString(newItem.frequency!) : '',
        newItem.times.map((t) => t.toIso8601String()).join(','),
        '${newItem.remindBefore?.inMinutes ?? 5}',
      );

      // Fetch updated list from server
      notifications = await api.getNotifications(user.id);
      events = notifications.data.where((e) => e.event_type == 'TreatmentItem').map((e) {
        return treatment.TreatmentItem(
          id: e.id,
          title: e.event_name ?? '',
          startDate: e.date_start,
          endDate: e.date_completion,
          frequency: e.periodicity != null ? _tfreqFromString(e.periodicity!) : null,
          times: e.time.split(',').map((t) => DateTime.parse(t)).toList(),
          remindBefore: Duration(minutes: int.parse(e.time_remind ?? "5")),
        );
      }).toList();

      // Update cache and return results
      await cache.saveTreatmentRegimen(events);
      return events;
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      // Read cache if no internet connection
      return await cache.loadTreatmentRegimen();
    }
  }

  Future<List<CalendarEventItem>> deleteCalendarEvent(CalendarEventItem item) async {
    try {
      // Check internet connection
      final result = await InternetAddress.lookup('example.com').timeout(const Duration(seconds: 3));
      if (result.isEmpty || result[0].rawAddress.isEmpty) throw Exception('No internet');

      // Get user id
      final user = await AuthRepository.instance.getUser();
      if (user == null) throw Exception('Not authenticated');

      // Fetch and parse calendar event list
      var notifications = await api.getNotifications(user.id);
      var events = notifications.data.where((e) => e.event_type == 'CalendarEventItem').map((e) {
        return CalendarEventItem(
          id: e.id,
          title: e.event_name != null ? _titleToType(e.event_name!) : EventType.appointment,
          description: e.what_remind,
          startDate: e.date_start,
          endDate: e.date_completion,
          frequency: e.periodicity != null ? _freqFromString(e.periodicity!) : Frequency.once,
          times: e.time.split(',').map((t) => DateTime.parse(t)).toList(),
          remindBefore: Duration(minutes: int.parse(e.time_remind ?? '5')),
        );
      }).toList();

      // Delete item and send delete request to the server
      events = events.where((e) => e.id != item.id).toList();
      if (item.id != null) await api.deleteNotification(item.id!);

      // Update cache and return results
      await cache.saveCalendarEvents(events);
      return events;
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      // Read cache if no internet connection
      return await cache.loadCalendarEvents();
    }
  }

  Future<List<treatment.TreatmentItem>> deleteTreatment(treatment.TreatmentItem item) async {
    try {
      // Check internet connection
      final result = await InternetAddress.lookup('example.com').timeout(const Duration(seconds: 3));
      if (result.isEmpty || result[0].rawAddress.isEmpty) throw Exception('No internet');

      // Get user id
      final user = await AuthRepository.instance.getUser();
      if (user == null) throw Exception('Not authenticated');

      // Fetch and parse calendar event list
      var notifications = await api.getNotifications(user.id);
      var events = notifications.data.where((e) => e.event_type == 'TreatmentItem').map((e) {
        return treatment.TreatmentItem(
          id: e.id,
          title: e.event_name ?? '',
          startDate: e.date_start,
          endDate: e.date_completion,
          frequency: e.periodicity != null ? _tfreqFromString(e.periodicity!) : null,
          times: e.time.split(',').map((t) => DateTime.parse(t)).toList(),
          remindBefore: Duration(minutes: int.parse(e.time_remind ?? "5")),
        );
      }).toList();

      // Delete item and send delete request to the server
      events = events.where((e) => e.id != item.id).toList();
      if (item.id != null) await api.deleteNotification(item.id!);

      // Update cache and return results
      await cache.saveTreatmentRegimen(events);
      return events;
    } catch (error, stacktrace) {
      print(error);
      print(stacktrace);
      // Read cache if no internet connection
      return await cache.loadTreatmentRegimen();
    }
  }

  String _typeToTitle(EventType title) {
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

  EventType _titleToType(String title) {
    if (title == "appointment".i18n()) {
      return EventType.appointment;
    } else if (title == "testing".i18n()) {
      return EventType.testing;
    } else if (title == "therapy".i18n()) {
      return EventType.therapy;
    }
    return EventType.other;
  }

  String _freqToString(Frequency freq) {
    switch (freq) {
      case Frequency.once:
        return "once".i18n();
      case Frequency.daily:
        return "daily".i18n();
      case Frequency.everyFewDays:
        return "every-few-days".i18n();
      case Frequency.onceAWeek:
        return "once-a-week".i18n();
      case Frequency.onceAMonth:
        return "once-a-month".i18n();
    }
  }

  String _tfreqToString(treatment.Frequency freq) {
    switch (freq) {
      case treatment.Frequency.once:
        return "once".i18n();
      case treatment.Frequency.daily:
        return "daily".i18n();
      case treatment.Frequency.everyFewDays:
        return "every-few-days".i18n();
      case treatment.Frequency.onceAWeek:
        return "once-a-week".i18n();
      case treatment.Frequency.onceAMonth:
        return "once-a-month".i18n();
    }
  }

  Frequency _freqFromString(String freq) {
    if (freq == "daily".i18n()) {
      return Frequency.daily;
    } else if (freq == "every-few-days".i18n()) {
      return Frequency.everyFewDays;
    } else if (freq == "once-a-week".i18n()) {
      return Frequency.onceAWeek;
    } else if (freq == "once-a-month".i18n()) {
      return Frequency.onceAMonth;
    }
    return Frequency.once;
  }

  treatment.Frequency _tfreqFromString(String freq) {
    if (freq == "daily".i18n()) {
      return treatment.Frequency.daily;
    } else if (freq == "every-few-days".i18n()) {
      return treatment.Frequency.everyFewDays;
    } else if (freq == "once-a-week".i18n()) {
      return treatment.Frequency.onceAWeek;
    } else if (freq == "once-a-month".i18n()) {
      return treatment.Frequency.onceAMonth;
    }
    return treatment.Frequency.once;
  }
}
