import 'package:coursezy/features/auth/domain/user_entity.dart';

class UserModel {
  final String id;
  final String email;

  UserModel({required this.id, required this.email});

  UserEntity toEntity() => UserEntity(id: id, email: email);

  static UserModel fromEntity(UserEntity entity) =>
      UserModel(id: entity.id, email: entity.email);
}
