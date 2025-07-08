import '../data/user_model.dart';
import '../domain/user_entity.dart';

class AuthRepository {
  UserModel? _user;

  Future<UserEntity?> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    _user = UserModel(id: '1', email: email);
    return _user?.toEntity();
  }

  Future<UserEntity?> create(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    _user = UserModel(id: '1', email: email);
    return _user?.toEntity();
  }

  Future<void> logout() async {
    _user = null;
  }

  UserEntity? get currentUser => _user?.toEntity();
}
