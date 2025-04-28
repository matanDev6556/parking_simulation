import 'package:pumba_ex/data/models/user_model.dart';

abstract class IUserRepository {
  Future<void> saveUser(UserModel user);
  Future<void> deleteUser(String userId);
  Future<UserModel?> getUser(String userId);
}
