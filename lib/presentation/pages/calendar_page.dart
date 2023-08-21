import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:vstrecha/bloc/auth_bloc.dart';
import 'package:vstrecha/bloc/calendar_bloc.dart';
import 'package:vstrecha/bloc/create_event_bloc.dart';
import 'package:vstrecha/bloc/main_bloc.dart';
import 'package:vstrecha/data/models/calendar_event.dart';
import 'package:vstrecha/presentation/widgets/calendar_event_card.dart';
import 'package:vstrecha/presentation/widgets/page_header.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        if (state is CalendarLoaded) {
          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: [
                PageHeader(
                  title: 'calendar'.i18n(),
                  disableBack: true,
                  actionIcon: SvgPicture.asset('assets/icons/add_black.svg'),
                  onActionTap: () {
                    AuthBloc auth = BlocProvider.of<AuthBloc>(context);
                    if (auth.state is AuthLoaded) {
                      MainBloc main = BlocProvider.of<MainBloc>(context);
                      final bloc = BlocProvider.of<CreateEventBloc>(context);
                      bloc.add(const LoadCreateEvent());
                      main.add(const PushPageEvent(path: '/events'));
                    } else {
                      showDialog<void>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: Text(
                              'authorization-required'.i18n(),
                              textAlign: TextAlign.start,
                            ),
                            content: Text(
                              'login-or-create-account'.i18n(),
                              textAlign: TextAlign.start,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('ok'.i18n()),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 0),
                          blurRadius: 10.0,
                          color: const Color(0xFF999999).withOpacity(0.15),
                        ),
                      ],
                    ),
                    child: CalendarDatePicker2(
                      config: CalendarDatePicker2Config(
                        calendarType: CalendarDatePicker2Type.single,
                        selectedDayHighlightColor: const Color(0xFF254CB1),
                        dayBuilder: ({
                          required DateTime date,
                          BoxDecoration? decoration,
                          bool? isDisabled,
                          bool? isSelected,
                          bool? isToday,
                          TextStyle? textStyle,
                        }) {
                          final bloc = BlocProvider.of<CalendarBloc>(context);
                          List<CalendarEventItem> events = bloc.getTodayEvents(state.events, date);

                          return SizedBox(
                            width: 30,
                            height: 30,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: isToday == true
                                      ? BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xff62aef3),
                                              Color(0xff254cb1),
                                              Color(0xff414dbc),
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                        )
                                      : null,
                                  child: Text(
                                    '${date.day}',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: isToday == true
                                          ? Colors.white
                                          : (isDisabled == true ? Colors.grey : Colors.black),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.only(top: 2)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: events
                                      .sublist(0, events.length > 3 ? 3 : events.length)
                                      .map((e) => Padding(
                                            padding: const EdgeInsets.only(right: 1),
                                            child: Container(
                                              width: 4,
                                              height: 4,
                                              decoration: BoxDecoration(
                                                color: _eventTypeColor(e.title),
                                                borderRadius: BorderRadius.circular(2),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      initialValue: const [],
                      onValueChanged: (value) {
                        MainBloc main = BlocProvider.of<MainBloc>(context);
                        CalendarBloc cal = BlocProvider.of<CalendarBloc>(context);
                        cal.add(LoadCalendarEvents(date: value.first));
                        main.add(const PushPageEvent(path: '/daily'));
                      },
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 24)),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    'today-events'.i18n(),
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 16)),
                ...state.todayEvents.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      bottom: 16,
                    ),
                    child: CalendarEventCard(
                      event: e,
                      color: _eventTypeColor(e.title),
                      onTap: () {
                        MainBloc main = BlocProvider.of<MainBloc>(context);
                        CreateEventBloc create = BlocProvider.of<CreateEventBloc>(context);
                        create.add(LoadCreateEvent(event: e));
                        main.add(const PushPageEvent(path: '/events'));
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Color _eventTypeColor(EventType type) {
    switch (type) {
      case EventType.appointment:
        return const Color(0xFF42E695);
      case EventType.testing:
        return const Color(0xFF005062);
      case EventType.therapy:
        return const Color(0xFF254CB1);
      case EventType.other:
        return const Color(0xFFFFA150);
    }
  }
}
