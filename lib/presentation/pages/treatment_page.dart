import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';

import 'package:vstrecha/bloc/create_treatment_bloc.dart';
import 'package:vstrecha/bloc/main_bloc.dart';
import 'package:vstrecha/bloc/treatment_bloc.dart';
import 'package:vstrecha/presentation/widgets/button.dart';
import 'package:vstrecha/presentation/widgets/menu_item.dart';
import 'package:vstrecha/presentation/widgets/page_header.dart';

class TreatmentPage extends StatefulWidget {
  const TreatmentPage({super.key});

  @override
  State<TreatmentPage> createState() => _TreatmentPageState();
}

class _TreatmentPageState extends State<TreatmentPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageHeader(
          title: 'treatment-regimen'.i18n(),
        ),
        Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: BlocBuilder<TreatmentBloc, TreatmentState>(
                    builder: (context, state) {
                      if (state is TreatmentLoaded) {
                        return ListView(
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          children: state.treatmentItems.isNotEmpty
                              ? state.treatmentItems
                                  .map((e) => MenuItem(
                                        onTap: () {
                                          CreateTreatmentBloc treatment =
                                              BlocProvider.of<
                                                  CreateTreatmentBloc>(context);
                                          MainBloc main =
                                              BlocProvider.of<MainBloc>(
                                                  context);
                                          treatment.add(
                                              LoadCreateTreatment(item: e));
                                          main.add(const PushPageEvent(
                                              path: '/create_treatment'));
                                        },
                                        trailing: SvgPicture.asset(
                                          'assets/icons/arrow.svg',
                                          width: 23,
                                          height: 23,
                                        ),
                                        label: e.title,
                                      ))
                                  .toList()
                              : [
                                  IntrinsicWidth(
                                    child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                              64,
                                              0x99,
                                              0x99,
                                              0x99,
                                            ),
                                            blurRadius: 10,
                                          ),
                                        ],
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'no-treatment'.i18n(),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                        );
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
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
                          CreateTreatmentBloc treatment =
                              BlocProvider.of<CreateTreatmentBloc>(context);
                          MainBloc main = BlocProvider.of<MainBloc>(context);
                          treatment.add(const LoadCreateTreatment());
                          main.add(
                              const PushPageEvent(path: '/create_treatment'));
                        },
                        enabled: true,
                        label: 'create-treatment'.i18n(),
                        leading: SvgPicture.asset('assets/icons/add.svg'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
