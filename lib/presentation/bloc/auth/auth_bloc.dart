import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pumba_ex/domain/usecases/auth_usecases.dart';
import 'package:pumba_ex/presentation/bloc/auth/auth_event.dart';
import 'package:pumba_ex/presentation/bloc/auth/auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckAuthStatusUseCase checkAuthStatusUseCase;
  final SignUpUserUseCase signUpUserUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  final LogoutUserUseCase logoutUserUseCase;

  AuthBloc({
    required this.checkAuthStatusUseCase,
    required this.signUpUserUseCase,
    required this.deleteAccountUseCase,
    required this.logoutUserUseCase,
  }) : super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<SignUpUser>(_onSignUpUser);
    on<DeleteAccount>(_onDeleteAccount);
    on<LogoutUser>(_onLogoutUser);
  }

  Future<void> _onCheckAuthStatus(
      CheckAuthStatus event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await checkAuthStatusUseCase();
      user != null ? emit(Authenticated(user)) : emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignUpUser(SignUpUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await signUpUserUseCase(
        event.userModel,
        event.password,
      );
      emit(Authenticated(user));
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage =
              'The email is already in use. Try to login or use another one.';
          break;
        case 'weak-password':
          errorMessage = 'The password is too weak. Try a stronger password.';
          break;
        case 'invalid-email':
          errorMessage = 'The email you provided is not valid.';
          break;
        default:
          errorMessage = e.message ?? 'Registration failed, please try again.';
      }
      emit(AuthError(errorMessage));
    } catch (e) {
      emit(AuthError('Unexpected error: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteAccount(DeleteAccount event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await deleteAccountUseCase(event.userId);
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogoutUser(LogoutUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await logoutUserUseCase();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}