import 'package:equatable/equatable.dart';
import 'package:pumba_ex/data/models/user_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthStatus extends AuthEvent {}

class SignUpUser extends AuthEvent {
  final String password;
  final UserModel userModel;

  const SignUpUser({required this.password, required this.userModel});

  @override
  List<Object> get props => [password, userModel];
}

class DeleteAccount extends AuthEvent {
  final String userId;

  const DeleteAccount({required this.userId});

  @override
  List<Object> get props => [userId];
}

class LogoutUser extends AuthEvent {}
