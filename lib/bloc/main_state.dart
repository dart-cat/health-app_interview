part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

class MainInitial extends MainState {}

class MainLoading extends MainState {}

class MainLoaded extends MainState {
  final List<Tuple2<String, int>> history;
  final Widget page;
  final int currentIndex;
  final bool enableBackground;
  final bool enableHeader;
  final bool enableNavbar;

  const MainLoaded({
    required this.history,
    required this.page,
    this.enableBackground = true,
    this.enableHeader = true,
    this.enableNavbar = true,
    this.currentIndex = 0,
  });
}

class MainError extends MainState {
  final String errorMessage;

  const MainError(this.errorMessage);
}
