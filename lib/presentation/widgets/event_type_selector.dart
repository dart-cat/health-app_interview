import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:vstrecha/bloc/main_bloc.dart';
import 'package:vstrecha/data/models/calendar_event.dart';

class EventTypeSelector extends StatelessWidget {
  final EventType? value;

  const EventTypeSelector({
    super.key,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'event-title'.i18n(),
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 4)),
        GestureDetector(
          onTap: () {
            final MainBloc main = BlocProvider.of<MainBloc>(context);
            main.add(const PushPageEvent(
              path: '/event_selector',
              enableBackground: false,
              enableHeader: false,
              enableNavbar: false,
            ));
          },
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
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      top: 14,
                      bottom: 14,
                    ),
                    child: value != null
                        ? Text(
                            _titleToString(value!),
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : Text(
                            'event-title'.i18n(),
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
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
