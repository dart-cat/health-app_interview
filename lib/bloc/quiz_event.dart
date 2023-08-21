part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

class LoadQuizEvent extends QuizEvent {}

class AnswersChangedEvent extends QuizEvent {
  final List<AllQuestion>? quiz;
  final int listIndex;
  const AnswersChangedEvent({required this.quiz, required this.listIndex});
}

class QuizDoneEvent extends QuizEvent {
 
  final int quizId;

  const QuizDoneEvent({required this.quizId});
}
