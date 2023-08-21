import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:vstrecha/data/models/user.dart';
import 'package:vstrecha/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    AuthRepository.instance.init();

    on<LoadEvent>((event, emit) async {
      emit(AuthLoading());

      User? user = await AuthRepository.instance.getUser();
      if (user != null) {
        emit(AuthLoaded(user: user));
      } else {
        emit(AuthInitial());
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());

      final user = await AuthRepository.instance.getUser(email: event.email, password: event.password);
      if (user == null) {
        return emit(const AuthError(errorMessage: 'Неправильный логин или пароль'));
      }

      emit(AuthLoaded(user: user));
    });

    on<CreateAccountEvent>((event, emit) async {
      emit(AuthLoading());

      final registrationResult = await AuthRepository.instance.createUser(
        email: event.email,
        password: event.password,
        gender: event.gender,
        typesUsers: event.typesUsers,
        city: event.city,
      );
      if (!registrationResult) {
        return emit(const AuthError(errorMessage: 'Ошибка регистрации'));
      }

      final user = await AuthRepository.instance.getUser(
        email: event.email,
        password: event.password,
      );
      if (user == null) {
        return emit(const AuthError(errorMessage: 'Неправильный логин или пароль'));
      }

      emit(AuthLoaded(user: user));
    });

    on<LogoutEvent>((event, emit) async {
      await AuthRepository.instance.deleteUser();
      emit(AuthInitial());
    });
  }
}
