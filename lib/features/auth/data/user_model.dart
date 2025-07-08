import 'package:coursezy/features/auth/domain/user_entity.dart';

class UserModel {
  final String id;
  final String email;
  final String phoneNumber;

  UserModel({required this.id, required this.email, this.phoneNumber = ''});

  UserEntity toEntity() =>
      UserEntity(id: id, email: email, phoneNumber: phoneNumber);

  static UserModel fromEntity(UserEntity entity) =>
      UserModel(id: entity.id, email: entity.email);
}
