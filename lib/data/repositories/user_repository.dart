import 'package:pumba_ex/data/models/user_model.dart';
import 'package:pumba_ex/data/services/firebase_service.dart';
import 'package:pumba_ex/domain/repositories/i_user_repository.dart';


class UserRepository implements IUserRepository {
  final FirebaseService _firebaseService;

  UserRepository({required FirebaseService firebaseService})
      : _firebaseService = firebaseService;

  @override
  Future<void> saveUser(UserModel user) async {
    await _firebaseService.saveUser(user);
  }

  @override
  Future<void> deleteUser(String userId) async {
    await _firebaseService.deleteUser(userId);
  }

  @override
  Future<UserModel?> getUser(String userId) async {
    return await _firebaseService.getUser(userId);
  }
}
