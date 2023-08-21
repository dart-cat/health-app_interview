part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class LoadMainEvent extends MainEvent {}

class ReplacePageEvent extends MainEvent {
  final String? path;
  final int? currentIndex;
  final bool? enableBackground;
  final bool? enableHeader;
  final bool? enableNavbar;

  const ReplacePageEvent({
    this.path,
    this.currentIndex,
    this.enableBackground,
    this.enableHeader,
    this.enableNavbar,
  });
}

class PushPageEvent extends MainEvent {
  final String? path;
  final int? currentIndex;
  final bool? enableBackground;
  final bool? enableHeader;
  final bool? enableNavbar;

  const PushPageEvent({
    this.path,
    this.currentIndex,
    this.enableBackground,
    this.enableHeader,
    this.enableNavbar,
  });
}

class PopPageEvent extends MainEvent {}
