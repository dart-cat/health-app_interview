import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:vstrecha/bloc/auth_bloc.dart';
import 'package:vstrecha/bloc/main_bloc.dart';
import 'package:vstrecha/presentation/widgets/button.dart';

import 'package:vstrecha/presentation/widgets/main_input.dart';
import 'package:vstrecha/presentation/widgets/page_header.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            children: [
              PageHeader(
                title: 'login'.i18n(),
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
                          hint: 'email'.i18n(),
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
                          hint: 'password'.i18n(),
                          label: 'password'.i18n(),
                          value: _password,
                          obscure: true,
                          onChanged: (value) {
                            setState(() {
                              _password = value;
                            });
                          },
                          isRequired: true,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 4)),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            'password-requirement'.i18n(),
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: const Color(0xFF979797),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 16)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'forgot-password'.i18n(),
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 40)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 229,
                              child: MainButton(
                                onTap: () {
                                  MainBloc bloc =
                                      BlocProvider.of<MainBloc>(context);
                                  AuthBloc auth =
                                      BlocProvider.of<AuthBloc>(context);
                                  auth.add(LoginEvent(
                                    email: _email,
                                    password: _password,
                                  ));
                                  bloc.add(PopPageEvent());
                                },
                                enabled:
                                    _email.isNotEmpty && _password.isNotEmpty,
                                label: 'login'.i18n(),
                              ),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 40)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 32,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'security'.i18n(),
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: const Color(0xFF979797),
                ),
              ),
              const Padding(padding: EdgeInsets.only(left: 4)),
              Text(
                'personal-data'.i18n(),
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: const Color(0xFF979797),
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
