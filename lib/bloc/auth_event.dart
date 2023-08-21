part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoadEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({
    required this.email,
    required this.password,
  });
}

class CreateAccountEvent extends AuthEvent {
  final String email;
  final String password;
  final String gender;
  final List<int> typesUsers;
  final String city;

  const CreateAccountEvent({
    required this.email,
    required this.password,
    required this.gender,
    required this.typesUsers,
    required this.city,
  });
}

class LogoutEvent extends AuthEvent {}
