import 'package:e_commerce_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.email,
    required super.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(email: json['email'], id: json['id']);
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email};
  }
}
