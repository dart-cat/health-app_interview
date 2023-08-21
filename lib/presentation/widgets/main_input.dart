import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainInput extends StatefulWidget {
  final String hint;
  final String label;
  final bool isRequired;
  final bool? obscure;
  final String? value;
  final Function(String)? onChanged;

  const MainInput({
    super.key,
    required this.hint,
    required this.label,
    required this.isRequired,
    this.obscure,
    this.value,
    this.onChanged,
  });

  @override
  State<MainInput> createState() => _MainInputState();
}

class _MainInputState extends State<MainInput> {
  final _controller = TextEditingController();
  String value = '';

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      _controller.text = widget.value!;
      setState(() {
        value = widget.value!;
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
        Container(
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
          child: TextField(
            controller: _controller,
            obscureText: widget.obscure ?? false,
            onChanged: (v) {
              setState(() {
                value = v;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(v);
              }
            },
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: widget.hint,
              hintStyle: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
