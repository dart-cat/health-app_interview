import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';

import 'package:vstrecha/bloc/analysis_bloc.dart';
import 'package:vstrecha/bloc/auth_bloc.dart';
import 'package:vstrecha/bloc/calendar_bloc.dart';
import 'package:vstrecha/bloc/create_event_bloc.dart';
import 'package:vstrecha/bloc/treatment_bloc.dart';
import 'package:vstrecha/bloc/create_treatment_bloc.dart';
import 'package:vstrecha/bloc/content_bloc.dart';
import 'package:vstrecha/bloc/hotlines_bloc.dart';
import 'package:vstrecha/bloc/institutions_bloc.dart';
import 'package:vstrecha/bloc/main_bloc.dart';
import 'package:vstrecha/bloc/quiz_bloc.dart';

import 'package:vstrecha/presentation/pages/analysis_page.dart';
import 'package:vstrecha/presentation/pages/calendar_page.dart';
import 'package:vstrecha/presentation/pages/calendar_event_page.dart';
import 'package:vstrecha/presentation/pages/chat_page.dart';
import 'package:vstrecha/presentation/pages/content_page.dart';
import 'package:vstrecha/presentation/pages/daily_events_page.dart';
import 'package:vstrecha/presentation/pages/event_type_selector_page.dart';
import 'package:vstrecha/presentation/pages/filters_page.dart';
import 'package:vstrecha/presentation/pages/help_abroad_page.dart';
import 'package:vstrecha/presentation/pages/home_page.dart';
import 'package:vstrecha/presentation/pages/hotlines_page.dart';
import 'package:vstrecha/presentation/pages/institution_detail_page.dart';
import 'package:vstrecha/presentation/pages/institutions_page.dart';
import 'package:vstrecha/presentation/pages/library_page.dart';
import 'package:vstrecha/presentation/pages/login_page.dart';
import 'package:vstrecha/presentation/pages/personal_area.dart';
import 'package:vstrecha/presentation/pages/quiz_page.dart';
import 'package:vstrecha/presentation/pages/registration_page.dart';
import 'package:vstrecha/presentation/pages/search_page.dart';
import 'package:vstrecha/presentation/pages/create_treatment_page.dart';
import 'package:vstrecha/presentation/pages/treatment_page.dart';

import 'package:vstrecha/presentation/screens/main_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    LocalJsonLocalization.delegate.directories = ['assets/locales'];
    _initializeNotifications();
  }

  Future<void> onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
  ) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  Future<void> onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  Future<void> _initializeNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        macOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
    await _requestNotificationPermissions();
  }

  Future<void> _requestNotificationPermissions() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => 'app-title'.i18n(),
      theme: ThemeData(primarySwatch: Colors.blue),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
      ],
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MainBloc(
              paths: {
                '/': const HomePage(),
                '/personal': const PersonalAreaPage(),
                '/library': const LibraryPage(),
                '/quiz': const QuizPage(),
                '/content': const ContentPage(),
                '/institutions': const InstitutionsPage(),
                '/institution': const InstitutionDetailPage(),
                '/abroad': const HelpAbroadPage(),
                '/registration': const RegistrationPage(),
                '/login': const LoginPage(),
                '/search': const SearchPage(),
                '/treatment': const TreatmentPage(),
                '/create_treatment': const CreateTreatmentPage(),
                '/calendar': const CalendarPage(),
                '/events': const CalendarEventPage(),
                '/event_selector': const EventTypeSelectorPage(),
                '/daily': const DailyEventsPage(),
                '/hotlines': const HotlinesPage(),
                '/analysis': const AnalysisPage(),
                '/chat': const ChatPage(),
                '/filters': const FiltersPage(),
              },
            ),
          ),
          BlocProvider(create: (context) => AnalysisBloc()),
          BlocProvider(create: (context) => CalendarBloc()),
          BlocProvider(create: (context) => CreateEventBloc()),
          BlocProvider(create: (context) => TreatmentBloc()),
          BlocProvider(create: (context) => CreateTreatmentBloc()),
          BlocProvider(create: (context) => QuizBloc()),
          BlocProvider(create: (context) => ContentBloc()),
          BlocProvider(create: (context) => InstitutionsBloc()),
          BlocProvider(create: (context) => HotlinesBloc()),
          BlocProvider(create: (context) => AuthBloc(), lazy: false),
        ],
        child: const MainScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
