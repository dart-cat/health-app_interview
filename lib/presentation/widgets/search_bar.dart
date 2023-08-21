import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MainSearchBar extends StatelessWidget {
  final Function(String) onChange;
  final String text;
  final String hint;
  final Widget? trailing;

  const MainSearchBar({
    super.key,
    required this.onChange,
    required this.text,
    required this.hint,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color(0xFFE6E6E6),
              ),
              borderRadius: BorderRadius.circular(100.0),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 0),
                  blurRadius: 10.0,
                  color: const Color(0xFF999999).withOpacity(0.15),
                ),
              ],
            ),
            child: TextField(
              controller: TextEditingController(text: text)
                ..selection = TextSelection.fromPosition(TextPosition(offset: text.length)),
              onChanged: onChange,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                icon: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: SvgPicture.asset('assets/icons/magnifier.svg'),
                ),
                contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(100),
                ),
                hintText: hint,
                hintStyle: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF979797),
                ),
              ),
            ),
          ),
        ),
        trailing != null
            ? Padding(
                padding: const EdgeInsets.only(left: 16),
                child: trailing,
              )
            : Container(),
      ],
    );
  }
}
