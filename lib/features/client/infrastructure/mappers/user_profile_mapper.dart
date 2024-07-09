import '../../domain/domain.dart';
import '../model/model.dart';

class UserProfileMapper {
  static UserProfile toUserProfileEntity(UserProfileModel userProfileModel) =>
      UserProfile(
        id: userProfileModel.id,
        email: userProfileModel.email,
        password: userProfileModel.password,
        username: userProfileModel.username,
        createdAt: userProfileModel.createdAt,
        name: userProfileModel.name ?? '',
        lastName: userProfileModel.lastName ?? '',
        phone: userProfileModel.phone ?? '',
        longitude: userProfileModel.longitude ?? 0,
        latitude: userProfileModel.latitude ?? 0,
        postalCode: userProfileModel.postalCode ?? '',
        city: userProfileModel.city ?? '',
        address: userProfileModel.address ?? '',
      );
}
