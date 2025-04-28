import 'package:pumba_ex/data/models/user_model.dart';
import 'package:pumba_ex/data/services/auth_service.dart';
import 'package:pumba_ex/domain/repositories/i_auth_repository.dart';

class AuthRepository implements IAuthRepository<UserModel> {
  final AuthService _authService;

  AuthRepository({required AuthService authService})
      : _authService = authService;

  @override
  Future<bool> isSignIn() async {
    final currentUser = _authService.currentUser;
    return currentUser != null;
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(
    UserModel userModel,
    String password,
  ) async {
    final user = await _authService.signUpWithEmailAndPassword(
      userModel.email,
      password,
    );
    return userModel.copyWith(id: user!.uid);
  }

  @override
  Future<void> signOut() async {
    await _authService.signOut();
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _authService.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<String> getCurrentUser() async {
    return _authService.currentUser?.uid ?? '';
  }
}
