import 'package:cotlear_app/features/auth/domain/entities/users.dart';

class UserMapper {
  static Users userJsonToEntity(Map<String, dynamic> json) => Users(
        id: json['id'] ?? json['sub'] ?? '',
        email: json['email'],
        password: json['password'],
        accountCreated: json['accountCreated'] ?? DateTime.now().toString(),
        accountStatus: json['accountStatus'] ?? DateTime.now().toString(),
        idTypeUser: json['idTypeUser'] ?? 1,
      );
}
