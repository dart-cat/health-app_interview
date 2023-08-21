import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:timelines/timelines.dart';

import 'package:vstrecha/bloc/calendar_bloc.dart';
import 'package:vstrecha/bloc/create_event_bloc.dart';
import 'package:vstrecha/bloc/main_bloc.dart';
import 'package:vstrecha/data/models/calendar_event.dart';
import 'package:vstrecha/presentation/widgets/menu_item.dart';
import 'package:vstrecha/presentation/widgets/page_header.dart';

class DailyEventsPage extends StatelessWidget {
  const DailyEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        if (state is CalendarLoaded) {
          Map<DateTime, CalendarEventItem> list = {};
          for (var e in state.dailyEvents) {
            for (var t in e.times) {
              list[t] = e;
            }
          }
          final sorted = list.entries.toList();
          sorted.sort((a, b) => a.key.hour - b.key.hour);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageHeader(
                title: DateFormat('dd MMMM', 'ru-RU').format(state.date!),
                onBackAction: () {
                  MainBloc main = BlocProvider.of<MainBloc>(context);
                  CalendarBloc cal = BlocProvider.of<CalendarBloc>(context);
                  cal.add(LoadCalendarEvents(date: DateTime.now()));
                  main.add(PopPageEvent());
                },
              ),
              Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: FixedTimeline.tileBuilder(
                          theme: TimelineThemeData(
                            nodePosition: 0,
                            indicatorTheme: const IndicatorThemeData(
                              color: Color(0xFF414DBC),
                            ),
                            connectorTheme: const ConnectorThemeData(
                              color: Color(0xFF414DBC),
                            ),
                          ),
                          builder: TimelineTileBuilder.connectedFromStyle(
                            itemCount: sorted.length,
                            contentsAlign: ContentsAlign.basic,
                            connectorStyleBuilder: (context, index) =>
                                ConnectorStyle.solidLine,
                            indicatorStyleBuilder: (context, index) =>
                                IndicatorStyle.dot,
                            contentsBuilder: (context, index) {
                              String time = DateFormat('HH', 'ru_RU')
                                  .format(sorted[index].key);
                              return Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 6),
                                  ),
                                  Text(
                                    '$time:00',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 15),
                                  ),
                                  Expanded(
                                    child: MenuItem(
                                      onTap: () {
                                        MainBloc main =
                                            BlocProvider.of<MainBloc>(context);
                                        CreateEventBloc create =
                                            BlocProvider.of<CreateEventBloc>(
                                                context);
                                        create.add(LoadCreateEvent(
                                            event: sorted[index].value));
                                        main.add(const PushPageEvent(
                                            path: '/events'));
                                      },
                                      trailing: SvgPicture.asset(
                                        'assets/icons/dots.svg',
                                      ),
                                      label: sorted[index].value.description ??
                                          _titleToString(
                                              sorted[index].value.title),
                                      padding: const EdgeInsets.only(
                                        top: 12,
                                        bottom: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        if (state is CalendarLoading) {
          return Column(
            children: [
              PageHeader(
                title: DateFormat('dd MMMM', 'ru-RU').format(state.date!),
              ),
              const CircularProgressIndicator(),
            ],
          );
        }
        if (state is CalendarError) {
          return Column(
            children: [
              PageHeader(
                title: DateFormat('dd MMMM', 'ru-RU').format(state.date),
              ),
              Expanded(
                child: Text(
                  'Ошибка загрузки',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
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
}
