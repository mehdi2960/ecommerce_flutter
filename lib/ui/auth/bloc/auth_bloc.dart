import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_ecommerce_flutter/common/exceptions.dart';
import 'package:nike_ecommerce_flutter/data/repo/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository authRepository;
  bool isLoginMode;
  AuthBloc(this.authRepository, {this.isLoginMode = true})
      : super(AuthInitial(isLoginMode)) {
    on<AuthEvent>(
      (event, emit) async {
        try {
          if (event is AuthButtonIsClicked) {
            emit(AuthLoading(isLoginMode));
            if (isLoginMode) {
              await authRepository.login(event.username, event.password);
              emit(AuthSuccess(isLoginMode));
            } else {
              await authRepository.register(event.username, event.password);
              emit(AuthSuccess(isLoginMode));
            }
          } else if (event is AuthModeChangIsClicked) {
            isLoginMode = !isLoginMode;
            emit(AuthInitial(isLoginMode));
          }
        } catch (e) {
          emit(AuthError(isLoginMode,AppException()));
        }
      },
    );
  }
}
