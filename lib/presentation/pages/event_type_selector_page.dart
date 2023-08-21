import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:vstrecha/bloc/create_event_bloc.dart';
import 'package:vstrecha/bloc/main_bloc.dart';
import 'package:vstrecha/data/models/calendar_event.dart';
import 'package:vstrecha/presentation/widgets/event_type_item.dart';
import 'package:vstrecha/presentation/widgets/page_header.dart';

class EventTypeSelectorPage extends StatelessWidget {
  const EventTypeSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PageHeader(
            title: 'event-title'.i18n(),
            headerPadding: false,
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: [
                EventTypeItem(
                  color: const Color(0xFF42E695),
                  label: 'appointment'.i18n(),
                  onTap: () {
                    final MainBloc mainBloc =
                        BlocProvider.of<MainBloc>(context);
                    final CreateEventBloc eventBloc =
                        BlocProvider.of<CreateEventBloc>(context);
                    eventBloc.add(
                      const SetEventTitle(
                        title: EventType.appointment,
                      ),
                    );
                    mainBloc.add(PopPageEvent());
                  },
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
                ),
                EventTypeItem(
                  color: const Color(0xFF005062),
                  label: 'testing'.i18n(),
                  onTap: () {
                    final MainBloc mainBloc =
                        BlocProvider.of<MainBloc>(context);
                    final CreateEventBloc eventBloc =
                        BlocProvider.of<CreateEventBloc>(context);
                    eventBloc.add(
                      const SetEventTitle(
                        title: EventType.testing,
                      ),
                    );
                    mainBloc.add(PopPageEvent());
                  },
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
                ),
                EventTypeItem(
                  color: const Color(0xFF254CB1),
                  label: 'therapy'.i18n(),
                  onTap: () {
                    final MainBloc mainBloc =
                        BlocProvider.of<MainBloc>(context);
                    final CreateEventBloc eventBloc =
                        BlocProvider.of<CreateEventBloc>(context);
                    eventBloc.add(
                      const SetEventTitle(
                        title: EventType.therapy,
                      ),
                    );
                    mainBloc.add(PopPageEvent());
                  },
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
                ),
                EventTypeItem(
                  color: const Color(0xFFFFA150),
                  label: 'other'.i18n(),
                  onTap: () {
                    final MainBloc mainBloc =
                        BlocProvider.of<MainBloc>(context);
                    final CreateEventBloc eventBloc =
                        BlocProvider.of<CreateEventBloc>(context);
                    eventBloc.add(
                      const SetEventTitle(
                        title: EventType.other,
                      ),
                    );
                    mainBloc.add(PopPageEvent());
                  },
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
