import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItem extends StatelessWidget {
  final Function() onTap;
  final String label;
  final Widget trailing;
  final Widget? leading;
  final EdgeInsets? padding;

  const MenuItem({
    super.key,
    required this.onTap,
    required this.trailing,
    required this.label,
    this.leading,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            foregroundColor: Colors.grey,
            backgroundColor: Colors.white,
            shadowColor: const Color(0x20999999),
            elevation: 4,
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 8,
                  right: (leading != null ? 8 : 0),
                ),
                child: leading,
              ),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: trailing,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
