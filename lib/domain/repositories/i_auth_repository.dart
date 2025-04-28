import 'package:pumba_ex/data/models/user_model.dart';

abstract class IAuthRepository<T> {
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<T?> signUpWithEmailAndPassword(UserModel userModel, String password);
  Future<void> signOut();
  Future<bool> isSignIn();
  Future<String> getCurrentUser();
}
