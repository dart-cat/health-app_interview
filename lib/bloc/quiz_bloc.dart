import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vstrecha/data/models/quiz.id.dart';
import 'package:vstrecha/data/models/quiz_questions_id.dart';
import 'package:vstrecha/data/providers/local_cache.dart';

import '../data/repositories/quiz_repository.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizInitial()) {
    on<LoadQuizEvent>((event, emit) async {
      emit(QuizLoading());
      final QuizId? quizId = await QuizRepository.instance.getQuiz();

      QuizRepository.instance.init;
      print(quizId?.data?.id);
      final List<AllQuestion> quiz =
          await QuizRepository.instance.getQuizQuestions();
      emit(QuizLoaded(quiz: quiz));
       //emit(const QuizError(errorMessage: 'o neeet vse propalo'));
    });
    on<AnswersChangedEvent>((event, emit) async {
      await const LocalCache().saveQuizId(event.listIndex);
      emit(QuizInitial());
      emit(QuizLoaded(quiz: event.quiz));
    });

    on<QuizDoneEvent>((event, emit) async {
      await QuizRepository.instance.postQuiz(event.quizId);
      emit(QuizDone());
    });
  }
}
  /*emit(QuizLoaded(
        quiz: Quiz(
          title: 'Заголовок опроса',
          questions: [
            QuizQuestion(question: 'Вопрос 1', checked: true),
            QuizQuestion(question: 'Вопрос 2', checked: true),
            QuizQuestion(question: 'Вопрос 3'),
            QuizQuestion(question: 'Вопрос 4'),
          ],
        ),
      ));*/