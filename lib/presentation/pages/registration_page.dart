import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:vstrecha/bloc/auth_bloc.dart';
import 'package:vstrecha/bloc/main_bloc.dart';
import 'package:vstrecha/presentation/widgets/button.dart';
import 'package:vstrecha/presentation/widgets/check_box.dart';
import 'package:vstrecha/presentation/widgets/dropdown.dart';
import 'package:vstrecha/presentation/widgets/main_input.dart';
import 'package:vstrecha/presentation/widgets/page_header.dart';
import 'package:vstrecha/presentation/widgets/toggle_block.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String _name = '';
  String _city = '';
  int _age = 4;
  String _sex = 'not-specified'.i18n();
  String _email = '';
  String _username = '';
  String _password1 = '';
  String _password2 = '';
  final List<int> _categories = [6];
  bool _agreement = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageHeader(
          title: 'registration'.i18n(),
          headerPadding: false,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: [
                  MainInput(
                    hint: 'enter-name'.i18n(),
                    label: 'name'.i18n(),
                    value: _name,
                    onChanged: (value) {
                      setState(() {
                        _name = value;
                      });
                    },
                    isRequired: true,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 16)),
                  MainInput(
                    hint: 'enter-city'.i18n(),
                    label: 'city'.i18n(),
                    value: _city,
                    onChanged: (value) {
                      setState(() {
                        _city = value;
                      });
                    },
                    isRequired: true,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 16)),
                  ToggleBlock(
                    label: 'age'.i18n(),
                    isRequired: false,
                    selection: _age,
                    selectionChanged: (value) {
                      setState(() {
                        _age = value;
                      });
                    },
                    values: [
                      'from-18-to-24-years'.i18n(),
                      'from-24-to-30-years'.i18n(),
                      'from-31-to-40-years'.i18n(),
                      'from-40-years'.i18n(),
                      'not-specified'.i18n(),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 16)),
                  ToggleBlock(
                    label: 'sex'.i18n(),
                    isRequired: false,
                    values: [
                      'male'.i18n(),
                      'female'.i18n(),
                      'not-specified'.i18n(),
                    ],
                    selection: _sex == 'male'.i18n()
                        ? 0
                        : _sex == 'female'.i18n()
                            ? 1
                            : 2,
                    selectionChanged: (value) {
                      setState(() {
                        switch (value) {
                          case 0:
                            _sex = 'male'.i18n();
                            break;
                          case 1:
                            _sex = 'female'.i18n();
                            break;
                          case 2:
                            _sex = 'not-specified'.i18n();
                            break;
                          default:
                            break;
                        }
                      });
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(top: 16)),
                  MainInput(
                    hint: 'enter-email'.i18n(),
                    label: 'email'.i18n(),
                    value: _email,
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                    isRequired: true,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 16)),
                  MainInput(
                    hint: 'enter-username'.i18n(),
                    label: 'username'.i18n(),
                    value: _username,
                    onChanged: (value) {
                      setState(() {
                        _username = value;
                      });
                    },
                    isRequired: true,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 16)),
                  MainInput(
                    hint: 'enter-password'.i18n(),
                    label: 'password'.i18n(),
                    value: _password1,
                    obscure: true,
                    onChanged: (value) {
                      setState(() {
                        _password1 = value;
                      });
                    },
                    isRequired: true,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 4)),
                  Text(
                    'password-requirement'.i18n(),
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF979797),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 16)),
                  MainInput(
                    hint: 'repeat-password'.i18n(),
                    label: 'password-repeated'.i18n(),
                    value: _password2,
                    obscure: true,
                    onChanged: (value) {
                      setState(() {
                        _password2 = value;
                      });
                    },
                    isRequired: true,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 16)),
                  DropDown(
                    hint: 'user-category'.i18n(),
                    label: 'user-category'.i18n(),
                    items: [
                      'PLH'.i18n(),
                      'PWID'.i18n(),
                      'CSW'.i18n(),
                      'MWM'.i18n(),
                      'TP'.i18n(),
                      'other'.i18n(),
                    ],
                    isRequired: true,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 32)),
                  Text(
                    'required-fields'.i18n(),
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 32)),
                  CheckBox(
                    onTap: () {
                      setState(() {
                        _agreement = !_agreement;
                      });
                    },
                    checked: _agreement,
                    label: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'permission-label'.i18n(),
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: 'personal-data'.i18n(),
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: const Color(0xFF0645AD),
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                final uri =
                                    Uri.parse('personal-data-url'.i18n());
                                final canLaunch = await canLaunchUrl(uri);
                                if (!canLaunch) return;
                                await launchUrl(
                                  uri,
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 32)),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 66,
                      right: 66,
                    ),
                    child: MainButton(
                      onTap: () {
                        MainBloc bloc = BlocProvider.of<MainBloc>(context);
                        AuthBloc auth = BlocProvider.of<AuthBloc>(context);
                        auth.add(CreateAccountEvent(
                          email: _email,
                          password: _password1,
                          gender: _sex.isEmpty ? 'not-specified'.i18n() : _sex,
                          typesUsers: _categories,
                          city: _city,
                        ));
                        bloc.add(PopPageEvent());
                      },
                      enabled: _agreement &&
                          _password1 == _password2 &&
                          _email.isNotEmpty &&
                          _password1.isNotEmpty &&
                          _username.isNotEmpty &&
                          _name.isNotEmpty &&
                          _city.isNotEmpty &&
                          _categories.isNotEmpty,
                      label: 'create-account'.i18n(),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 40)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
