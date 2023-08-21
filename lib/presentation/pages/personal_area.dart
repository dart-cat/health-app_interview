import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';

import 'package:vstrecha/bloc/main_bloc.dart';
import 'package:vstrecha/bloc/treatment_bloc.dart';
import 'package:vstrecha/bloc/auth_bloc.dart';
import 'package:vstrecha/presentation/widgets/button.dart';
import 'package:vstrecha/presentation/widgets/menu_item.dart';
import 'package:vstrecha/presentation/widgets/page_header.dart';

class PersonalAreaPage extends StatefulWidget {
  const PersonalAreaPage({super.key});

  @override
  State<PersonalAreaPage> createState() => _PersonalAreaPageState();
}

class _PersonalAreaPageState extends State<PersonalAreaPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(LoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoaded) {
          return Column(
            children: [
              PageHeader(
                title: 'personal-area'.i18n(),
                disableBack: true,
              ),
              Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    children: [
                      MenuItem(
                        onTap: () {
                          MainBloc bloc = BlocProvider.of<MainBloc>(context);
                          bloc.add(const PushPageEvent(path: '/analysis'));
                        },
                        trailing: SvgPicture.asset(
                          'assets/icons/arrow.svg',
                          width: 23,
                          height: 23,
                        ),
                        label: 'analysis-data'.i18n(),
                      ),
                      MenuItem(
                        onTap: () {
                          TreatmentBloc treatment = BlocProvider.of<TreatmentBloc>(context);
                          MainBloc main = BlocProvider.of<MainBloc>(context);
                          treatment.add(LoadTreatment());
                          main.add(const PushPageEvent(path: '/treatment'));
                        },
                        trailing: SvgPicture.asset(
                          'assets/icons/arrow.svg',
                          width: 23,
                          height: 23,
                        ),
                        label: 'treatment-regimen'.i18n(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        if (state is AuthInitial || state is AuthError) {
          if (state is AuthError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text(
                      'error'.i18n(),
                      textAlign: TextAlign.start,
                    ),
                    content: Text(
                      state.errorMessage,
                      textAlign: TextAlign.start,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('ok'.i18n()),
                      ),
                    ],
                  );
                },
              );
            });
            BlocProvider.of<AuthBloc>(context).add(LoadEvent());
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'personal-area'.i18n(),
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 40)),
                SizedBox(
                  width: 229,
                  child: MainButton(
                    onTap: () {
                      BlocProvider.of<MainBloc>(context).add(
                        const PushPageEvent(
                          path: '/login',
                          enableBackground: false,
                          enableHeader: false,
                        ),
                      );
                    },
                    enabled: true,
                    label: 'login'.i18n(),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 32)),
                SizedBox(
                  width: 229,
                  child: MainButton(
                    onTap: () {
                      BlocProvider.of<MainBloc>(context).add(
                        const PushPageEvent(
                          path: '/registration',
                          enableBackground: false,
                          enableHeader: false,
                        ),
                      );
                    },
                    enabled: true,
                    label: 'registration'.i18n(),
                    style: MainButtonStyle.outline,
                  ),
                ),
              ],
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
