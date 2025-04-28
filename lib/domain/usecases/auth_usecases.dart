import 'package:pumba_ex/data/models/user_model.dart';
import 'package:pumba_ex/domain/repositories/i_auth_repository.dart';
import 'package:pumba_ex/domain/repositories/i_user_repository.dart';

class CheckAuthStatusUseCase {
  final IAuthRepository<UserModel> authRepository;
  final IUserRepository userRepository;

  CheckAuthStatusUseCase({
    required this.authRepository,
    required this.userRepository,
  });

  Future<UserModel?> call() async {
    final isSignIn = await authRepository.isSignIn();
    if (isSignIn) {
      final userUid = await authRepository.getCurrentUser();
      return await userRepository.getUser(userUid);
    }
    return null;
  }
}

class SignUpUserUseCase {
  final IAuthRepository<UserModel> authRepository;
  final IUserRepository userRepository;

  SignUpUserUseCase({
    required this.authRepository,
    required this.userRepository,
  });

  Future<UserModel> call(UserModel userModel, String password) async {
    final user = await authRepository.signUpWithEmailAndPassword(
      userModel,
      password,
    );
    await userRepository.saveUser(user!);
    return user;
  }
}

class DeleteAccountUseCase {
  final IAuthRepository<UserModel> authRepository;
  final IUserRepository userRepository;

  DeleteAccountUseCase({
    required this.authRepository,
    required this.userRepository,
  });

  Future<void> call(String userId) async {
    await userRepository.deleteUser(userId);
    await authRepository.signOut();
  }
}



class LogoutUserUseCase {
  final IAuthRepository<UserModel> authRepository;

  LogoutUserUseCase({required this.authRepository});

  Future<void> call() async {
    await authRepository.signOut();
  }
}
