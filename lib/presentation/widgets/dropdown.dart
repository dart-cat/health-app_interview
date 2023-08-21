import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vstrecha/presentation/widgets/toggle_block.dart';

class DropDown extends StatefulWidget {
  final List<String> items;
  final String hint;
  final String? label;
  final bool? isRequired;
  final String? value;
  final Function(String)? onChanged;

  const DropDown({
    super.key,
    required this.items,
    required this.hint,
    this.label,
    this.isRequired,
    this.value,
    this.onChanged,
  });

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  bool expanded = false;
  int? selectedItem;

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      int index = widget.items.indexOf(widget.value!);
      setState(() {
        selectedItem = index;
      });
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
        GestureDetector(
          onTap: () {
            setState(() {
              expanded = !expanded;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  expanded ? BorderRadius.zero : BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 0),
                  blurRadius: 10.0,
                  color: const Color(0xFF999999).withOpacity(0.15),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          top: 14,
                          bottom: 14,
                        ),
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          selectedItem != null
                              ? widget.items[selectedItem!]
                              : widget.hint,
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: selectedItem != null
                                ? Colors.black
                                : const Color(0xff979797),
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
                      child: SvgPicture.asset(
                        'assets/icons/down_arrow_black.svg',
                      ),
                    ),
                  ],
                ),
                expanded
                    ? ToggleBlock(
                        disableDecoration: true,
                        values: widget.items,
                        selection: selectedItem,
                        selectionChanged: (s) {
                          setState(() {
                            selectedItem = s;
                          });
                          if (widget.onChanged != null) {
                            widget.onChanged!(widget.items[s]);
                          }
                        },
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
