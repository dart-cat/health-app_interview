part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizDone extends QuizState {}

class QuizLoaded extends QuizState {
  final List<AllQuestion>? quiz;

  const QuizLoaded({required this.quiz});
}

class QuizError extends QuizState {
  final String errorMessage;

  const QuizError({required this.errorMessage});
}
