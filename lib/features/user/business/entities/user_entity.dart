import 'types/storage_location.dart';

class UserEntity {
  final String username;
  final String email; // for restoring password
  final String passwordHash;
  final int versionsLifetimeInDays; // if 0 - do not save versions
  final bool encryptFiles;
  final StorageLocation storageLocation;

  const UserEntity({
    required this.username,
    required this.email,
    required this.passwordHash,
    this.versionsLifetimeInDays = 30,
    this.encryptFiles = true,
    this.storageLocation = StorageLocation.personalDevice,
  });
}
