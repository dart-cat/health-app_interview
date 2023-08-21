import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventTypeItem extends StatelessWidget {
  final Color color;
  final String label;
  final Function() onTap;

  const EventTypeItem({
    super.key,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 24,
          left: 8,
          right: 8,
          bottom: 10,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
                right: 8,
              ),
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: color,
                ),
              ),
            ),
            Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
