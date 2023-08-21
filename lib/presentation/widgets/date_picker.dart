import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final String label;
  final bool isRequired;
  final DateTime? value;
  final Function(DateTime)? onChanged;

  const DatePicker({
    super.key,
    required this.label,
    required this.isRequired,
    this.value,
    this.onChanged,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  bool expanded = false;
  DateTime? selectedDate;
  String selectedLabel = 'Дата не выбрана';

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      final date = widget.value;
      setState(() {
        selectedDate = date;
        selectedLabel = DateFormat(
          'dd MMMM yyyy',
          'ru_RU',
        ).format(date!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.label,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            widget.isRequired
                ? Text(
                    '*',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFFE0000),
                    ),
                  )
                : Container(),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 4)),
        GestureDetector(
          onTap: () {
            setState(() {
              expanded = !expanded;
            });
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
                    child: Text(
                      selectedLabel,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff979797),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.5,
                    bottom: 10.5,
                    right: 8,
                  ),
                  child: SvgPicture.asset('assets/icons/schedule_black.svg'),
                ),
              ],
            ),
          ),
        ),
        expanded
            ? const Padding(padding: EdgeInsets.only(top: 16))
            : Container(),
        expanded
            ? Container(
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
                  ),
                  initialValue:
                      selectedDate != null ? [selectedDate] : const [],
                  onValueChanged: (value) {
                    setState(() {
                      if (value.isNotEmpty) {
                        final date = value.first;
                        selectedDate = date;
                        selectedLabel = DateFormat(
                          'dd MMMM yyyy',
                          'ru_RU',
                        ).format(date!);
                        if (widget.onChanged != null) {
                          widget.onChanged!(selectedDate!);
                        }
                      } else {
                        selectedDate = null;
                        selectedLabel = 'Дата не выбрана';
                      }
                    });
                  },
                ),
              )
            : Container(),
      ],
    );
  }
}
