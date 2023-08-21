import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainToggle extends StatelessWidget {
  final Function() onTap;
  final bool enabled;
  final String label;
  final Color? textColor;

  const MainToggle({
    super.key,
    required this.onTap,
    required this.enabled,
    required this.label,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 168, 211, 251),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 1,
                      spreadRadius: 2,
                    )
                  ],
                  borderRadius: BorderRadius.circular(8),
                  gradient: (enabled
                      ? const LinearGradient(
                          colors: [
                            Color(0xff62aef3),
                            Color(0xff254cb1),
                            Color(0xff414dbc),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )
                      : null),
                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(left: 8)),
          Flexible(
            child: Text(
              label,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: textColor,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
