import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vstrecha/bloc/main_bloc.dart';
import 'package:vstrecha/presentation/widgets/button.dart';
import 'package:vstrecha/presentation/widgets/check_box.dart';

class AgeCheckScreen extends StatefulWidget {
  const AgeCheckScreen({super.key});

  @override
  State<AgeCheckScreen> createState() => _AgeCheckScreenState();
}

class _AgeCheckScreenState extends State<AgeCheckScreen> {
  bool _checked = false;

  Future<void> _confirm() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('initialCheck', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff62aef3),
              Color(0xff254cb1),
              Color(0xff414dbc),
            ],
            begin: Alignment(-1.7, 0.8),
            end: Alignment(1, 1),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              bottom: MediaQuery.of(context).size.height * 0.07,
              child: SvgPicture.asset(
                'assets/age_check/left-side_decoration.svg',
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: SvgPicture.asset(
                'assets/age_check/bottom-right_decoration.svg',
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/age_check/law_icon.png',
                  width: 116,
                  height: 117,
                ),
                const Padding(padding: EdgeInsets.only(top: 36)),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 255, 135, 29),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'age-check-text'.i18n(),
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 5,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 41)),
                SizedBox(
                  width: 260,
                  child: CheckBox(
                    onTap: () => setState(() => _checked = !_checked),
                    checked: _checked,
                    label: Text(
                      'age-check-confirm-label'.i18n(),
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 40)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 229,
                      child: MainButton(
                        onTap: () {
                          _confirm().then((_) {
                            BlocProvider.of<MainBloc>(context)
                                .add(LoadMainEvent());
                          });
                        },
                        enabled: _checked,
                        label: 'age-check-btn-label'.i18n(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
