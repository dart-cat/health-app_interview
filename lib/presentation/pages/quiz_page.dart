import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';

import 'package:vstrecha/bloc/quiz_bloc.dart';
import 'package:vstrecha/presentation/widgets/button.dart';
import 'package:vstrecha/presentation/widgets/page_header.dart';
import 'package:vstrecha/presentation/widgets/quiz_card.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    super.initState();
    _loadQuiz();
  }

  void _loadQuiz() {
    BlocProvider.of<QuizBloc>(context).add(LoadQuizEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageHeader(title: 'quiz'.i18n()),
        BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            if (state is QuizDone) {
              return Container(
                constraints: const BoxConstraints.tightFor(width: 334),
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 6,
                  shadowColor: const Color(0x40999999),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 32)),
                      SvgPicture.asset('assets/icons/quiz_checkmark.svg'),
                      const Padding(padding: EdgeInsets.only(top: 16)),
                      Text(
                        'quiz-done'.i18n(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 40)),
                    ],
                  ),
                ),
              );
            }
            if (state is QuizError) {
              return Container(
                constraints: const BoxConstraints.tightFor(width: 334),
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 6,
                  shadowColor: const Color(0x40999999),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 32)),
                      SvgPicture.asset('assets/icons/quiz.svg'),
                      const Padding(padding: EdgeInsets.only(top: 16)),
                      Text(
                        'quiz-no-active'.i18n(),
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 40)),
                    ],
                  ),
                ),
              );
            }
            if (state is QuizLoaded) {
              return Expanded(
                child: Stack(
                  children: [
                    ListView( 
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 110),
                          child: QuizCard(quiz: state.quiz!),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 40,
                      left: 65,
                      right: 65,
                      child: MainButton(
                        onTap: () {
                          print ('--------> квиз 0 = ${state.quiz![0].id}');
                            BlocProvider.of<QuizBloc>(context)
                                .add(QuizDoneEvent(quizId: state.quiz![0].id ?? 0) );
                        },
                        enabled: true,
                        label: 'submit'.i18n(),
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
        ),
      ],
    );
  }
}
