import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum MainButtonStyle { primary, outline }

class MainButton extends StatelessWidget {
  final Function() onTap;
  final bool enabled;
  final String label;
  final MainButtonStyle style;
  final Widget? leading;

  const MainButton({
    super.key,
    required this.onTap,
    required this.enabled,
    required this.label,
    this.style = MainButtonStyle.primary,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        gradient: (enabled
            ? const LinearGradient(
                colors: [
                  Color(0xffff851d),
                  Color(0xffffa150),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null),
        color: (enabled ? null : const Color(0xffbdbdbd)),
      ),
      child: Padding(
        padding: (style == MainButtonStyle.outline && enabled
            ? const EdgeInsets.all(1)
            : EdgeInsets.zero),
        child: ElevatedButton(
          onPressed: (enabled ? onTap : null),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            foregroundColor: (enabled
                ? (style == MainButtonStyle.outline ? Colors.grey : null)
                : const Color(0xffbdbdbd)),
            backgroundColor: (style == MainButtonStyle.outline && enabled
                ? Colors.white
                : Colors.transparent),
            shadowColor: Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              leading != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: leading,
                    )
                  : Container(),
              Text(
                label,
                style: GoogleFonts.montserrat(
                  color: (style == MainButtonStyle.outline && enabled
                      ? Colors.black
                      : Colors.white),
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
