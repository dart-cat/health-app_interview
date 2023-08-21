import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vstrecha/presentation/widgets/main_toggle.dart';

class ToggleBlock extends StatefulWidget {
  final String? label;
  final bool? isRequired;
  final bool? disableDecoration;
  final int? selection;
  final Function(int)? selectionChanged;
  final List<String> values;

  const ToggleBlock({
    super.key,
    this.label,
    this.isRequired,
    this.disableDecoration,
    this.selection,
    this.selectionChanged,
    required this.values,
  });

  @override
  State<ToggleBlock> createState() => _ToggleBlockState();
}

class _ToggleBlockState extends State<ToggleBlock> {
  int selection = 0;

  @override
  void initState() {
    super.initState();
    if (widget.selection != null) {
      selection = widget.selection!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.label != null
            ? Row(
                children: [
                  Text(
                    widget.label!,
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  widget.isRequired!
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
              )
            : Container(),
        widget.label != null
            ? const Padding(padding: EdgeInsets.only(top: 4))
            : Container(),
        Container(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
            top: 10,
            bottom: 10,
          ),
          decoration: widget.disableDecoration == true
              ? null
              : BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.zero,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 0),
                      blurRadius: 10.0,
                      color: const Color(0xFF999999).withOpacity(0.15),
                    ),
                  ],
                ),
          child: Wrap(
            runSpacing: 20,
            children: widget.values
                .map(
                  (e) => MainToggle(
                    onTap: () {
                      setState(() {
                        selection = widget.values.indexOf(e);
                        if (widget.selectionChanged != null) {
                          widget.selectionChanged!(selection);
                        }
                      });
                    },
                    enabled: e == widget.values[selection],
                    label: e,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
