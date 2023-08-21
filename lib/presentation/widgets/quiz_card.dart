import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vstrecha/bloc/quiz_bloc.dart';

import 'package:vstrecha/data/models/quiz_questions_id.dart';
import 'package:vstrecha/presentation/widgets/check_box.dart';

class QuizCard extends StatelessWidget {
  final List<AllQuestion> quiz;


  const QuizCard({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.tightFor(width: 334, height: 204),
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 6,
        shadowColor: const Color(0x40999999),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            bottom: 16,
            left: 8,
            right: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quiz.first.question ?? ' ',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: quiz[0].answers.length,
                  itemBuilder: (BuildContext context, int index) {
                    final quizs = quiz[0].answers[index];
                    bool checked = quizs.answer ?? false;
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: CheckBox(
                        onTap: () {
                          
                            quizs.answer = !checked; 
                            BlocProvider.of<QuizBloc>(context)
                              .add(AnswersChangedEvent(quiz: quiz, listIndex: quizs.id ?? 0 ));
                        },
                        
                        checked: checked,
                        label: Text(
                          quizs.text ?? ' ',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//  child: Column(children: [Text(quizs.text,
                    //  style:GoogleFonts.montserrat(
                    //         fontWeight: FontWeight.w400,
                    //         fontSize: 12,
                    //       ),
                    //       textAlign: TextAlign.left,
                          
                    //       )]
                    //       ),