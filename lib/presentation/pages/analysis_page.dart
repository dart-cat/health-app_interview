import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'package:vstrecha/bloc/analysis_bloc.dart';
import 'package:vstrecha/bloc/main_bloc.dart';
import 'package:vstrecha/data/models/analysis.dart';
import 'package:vstrecha/presentation/widgets/button.dart';
import 'package:vstrecha/presentation/widgets/page_header.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  final List<String> sortDirections = [
    'new-first'.i18n(),
    'old-first'.i18n(),
  ];

  final PanelController panelController = PanelController();
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    final bloc = BlocProvider.of<AnalysisBloc>(context);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) => _overlay(bloc));
    if (bloc.state is AnalysisLoaded) {
      final loaded = bloc.state as AnalysisLoaded;
      selectedValue = loaded.order == SortOrder.descending ? 'new-first'.i18n() : 'old-first'.i18n();
    } else {
      bloc.add(LoadAnalysis());
    }
  }

  bool _interceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    BackButtonInterceptor.remove(_interceptor);
    panelController.close();
    return true;
  }

  void _overlay(AnalysisBloc bloc) {
    final overlay = OverlayEntry(
      builder: (context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SlidingUpPanel(
            backdropEnabled: true,
            minHeight: 0,
            maxHeight: 237,
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
                              panelController.close();
                            });
                            BackButtonInterceptor.remove(_interceptor);
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 50)),
                    InkWell(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(source: ImageSource.camera);
                        if (image != null) {
                          bloc.add(
                            AddAnalysis(
                              item: AnalysisItem(
                                path: image.path,
                                date: DateTime.now(),
                              ),
                            ),
                          );
                        }
                        panelController.close();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          top: 16,
                          bottom: 16,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/photo.svg'),
                            const Padding(padding: EdgeInsets.only(left: 16)),
                            Text(
                              'camera'.i18n(),
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD9D9D9),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          bloc.add(
                            AddAnalysis(
                              item: AnalysisItem(
                                path: image.path,
                                date: await image.lastModified(),
                              ),
                            ),
                          );
                        }
                        panelController.close();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          top: 16,
                          bottom: 16,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/picture.svg'),
                            const Padding(padding: EdgeInsets.only(left: 16)),
                            Text(
                              'gallery'.i18n(),
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD9D9D9),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          bloc.add(
                            AddAnalysis(
                              item: AnalysisItem(
                                path: image.path,
                                date: await image.lastModified(),
                              ),
                            ),
                          );
                        }
                        panelController.close();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          top: 16,
                          bottom: 16,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/document.svg'),
                            const Padding(padding: EdgeInsets.only(left: 16)),
                            Text(
                              'document'.i18n(),
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
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

  DropdownMenuItem<String> makeItem(String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(
        value,
        style: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            PageHeader(
              title: 'analysis-data'.i18n(),
              onBackAction: () {
                MainBloc bloc = BlocProvider.of<MainBloc>(context);
                BackButtonInterceptor.remove(_interceptor);
                panelController.close();
                bloc.add(PopPageEvent());
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: Row(
                children: [
                  Text(
                    'order-by'.i18n(),
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 8)),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      selectedItemBuilder: (context) {
                        return sortDirections
                            .map(
                              (e) => Padding(
                                padding: EdgeInsets.only(
                                  left: selectedValue == e ? 10 : 0,
                                  top: 4,
                                ),
                                child: Text(
                                  e,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            )
                            .toList();
                      },
                      items: sortDirections.map((e) => makeItem(e)).toList(),
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'new-first'.i18n(),
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;
                        });

                        final bloc = BlocProvider.of<AnalysisBloc>(context);
                        if (value == 'new-first'.i18n()) {
                          bloc.add(const SortAnalysis(order: SortOrder.descending));
                        } else {
                          bloc.add(const SortAnalysis(order: SortOrder.ascending));
                        }
                      },
                      buttonStyleData: ButtonStyleData(
                        width: 152,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 0),
                              blurRadius: 10.0,
                              color: const Color(0xFF999999).withOpacity(0.15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 19)),
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: BlocBuilder<AnalysisBloc, AnalysisState>(
                  builder: (context, state) {
                    if (state is AnalysisLoaded) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        itemCount: state.images.length,
                        itemExtent: 450,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 16,
                                child: Image(
                                  height: 400,
                                  image: CachedNetworkImageProvider(
                                    state.images[index].path,
                                  ),
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Shimmer(
                                      child: Container(
                                        height: 400,
                                        color: Colors.grey.shade300,
                                      ),
                                    );
                                  },
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 8,
                                      bottom: 24,
                                    ),
                                    child: Text(
                                      '${'date'.i18n()} ${DateFormat('dd.MM.yyyy').format(state.images[index].date)}',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 31,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainButton(
                onTap: () {
                  setState(() {
                    panelController.open();
                  });
                  BackButtonInterceptor.add(_interceptor);
                },
                enabled: true,
                label: 'add-analysis'.i18n(),
                leading: SvgPicture.asset('assets/icons/add.svg'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
