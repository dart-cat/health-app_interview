import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class WheelPicker extends StatefulWidget {
  final String? label;
  final bool? isRequired;
  final List<String> items;
  final String? value;
  final PanelController? controller;
  final Function(String)? onChanged;

  const WheelPicker({
    super.key,
    this.label,
    this.isRequired,
    this.onChanged,
    this.value,
    this.controller,
    required this.items,
  });

  @override
  State<WheelPicker> createState() => _WheelPickerState();
}

class _WheelPickerState extends State<WheelPicker> {
  late PanelController panelController;
  FixedExtentScrollController scrollController = FixedExtentScrollController();

  int selectedItem = 0;
  int previousItem = 0;

  @override
  void initState() {
    super.initState();
    panelController = widget.controller ?? PanelController();
    if (widget.value != null) {
      int index = widget.items.indexOf(widget.value!);
      setState(() {
        selectedItem = index;
        previousItem = index;
      });
      scrollController.jumpToItem(index);
    }
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) => _overlay());
  }

  bool _interceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    BackButtonInterceptor.remove(_interceptor);
    panelController.close();
    return true;
  }

  void _overlay() {
    final overlay = OverlayEntry(
      builder: (context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SlidingUpPanel(
            backdropEnabled: true,
            minHeight: 0,
            maxHeight: 310,
            borderRadius: BorderRadius.circular(16),
            defaultPanelState: PanelState.CLOSED,
            controller: panelController,
            header: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Material(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 20),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedItem = previousItem;
                              scrollController.jumpToItem(previousItem);
                            });
                            BackButtonInterceptor.remove(_interceptor);
                            panelController.close();
                          },
                          child: Text(
                            'abort'.i18n(),
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16, top: 20),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              previousItem = selectedItem;
                            });
                            if (widget.onChanged != null) {
                              widget.onChanged!(widget.items[selectedItem]);
                            }
                            BackButtonInterceptor.remove(_interceptor);
                            panelController.close();
                          },
                          child: Text(
                            'apply'.i18n(),
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            panel: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Material(
                child: Stack(
                  children: [
                    Positioned(
                      top: 58,
                      left: 0,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: ListWheelScrollView(
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          itemExtent: 50,
                          overAndUnderCenterOpacity: 0.3,
                          controller: scrollController,
                          onSelectedItemChanged: (index) {
                            setState(() {
                              selectedItem = index;
                            });
                          },
                          children: widget.items
                              .map(
                                (e) => Text(
                                  e,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 120,
                      left: 67,
                      right: 67,
                      child: Container(
                        height: 1,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF62AEF3),
                              Color(0xFF254CB1),
                              Color(0xFF414DBC),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 170,
                      left: 67,
                      right: 67,
                      child: Container(
                        height: 1,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF62AEF3),
                              Color(0xFF254CB1),
                              Color(0xFF414DBC),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    Overlay.of(context).insert(overlay);
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
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  panelController.open();
                  BackButtonInterceptor.add(_interceptor);
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
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        top: 14,
                        bottom: 14,
                      ),
                      child: Text(
                        widget.items[selectedItem],
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff979797),
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
                        'assets/icons/down_arrow_grey.svg',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
