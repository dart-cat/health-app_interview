import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:vstrecha/data/models/calendar_event.dart';

class CalendarEventCard extends StatelessWidget {
  final CalendarEventItem event;
  final Color color;
  final Function()? onTap;

  const CalendarEventCard({
    super.key,
    required this.event,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 10.0,
            color: const Color(0xFF999999).withOpacity(0.15),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            foregroundColor: Colors.grey,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          child: Container(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 4,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.description ?? _titleToString(event.title),
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        event.times
                            .map((e) =>
                                '${e.hour.toString().padLeft(2, '0')}:${e.minute.toString().padLeft(2, '0')}')
                            .toList()
                            .join(', '),
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF979797),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: SvgPicture.asset('assets/icons/arrow.svg'),
                ),
              ],
            ),
          ),
        ),
      ),
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
