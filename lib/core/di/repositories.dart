import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/library_management/business/repository_interfaces/category_repository.dart';
import '../../features/library_management/business/repository_interfaces/collection_repository.dart';
import '../../features/library_management/business/repository_interfaces/file_repository.dart';
import '../../features/library_management/business/repository_interfaces/tag_repository.dart';
import '../../features/library_management/data/repositories/category_repository_impl.dart';
import '../../features/library_management/data/repositories/collection_repository_impl.dart';
import '../../features/library_management/data/repositories/file_repository_impl.dart';
import '../../features/library_management/data/repositories/tag_repository_impl.dart';
import '../../features/synchronization/business/repository_interfaces/device_repository.dart';
import '../../features/synchronization/data/repositories/device_repository_impl.dart';
import '../../features/version_control/business/repository_interfaces/file_version_repository.dart';
import '../../features/version_control/data/repositories/file_version_repository_impl.dart';
import '../common/business/repository_interfaces/user_repository.dart';
import '../common/data/repositories/user_repository_impl.dart';

part 'repositories.g.dart';

@riverpod
CategoryRepository categoryRepository(CategoryRepositoryRef ref) {
  return CategoryRepositoryImpl();
}

@riverpod
CollectionRepository collectionRepository(CollectionRepositoryRef ref) {
  return CollectionRepositoryImpl();
}

@riverpod
FileRepository fileRepository(FileRepositoryRef ref) {
  return FileRepositoryImpl();
}

@riverpod
TagRepository tagRepository(TagRepositoryRef ref) {
  return TagRepositoryImpl();
}

@riverpod
FileVersionRepository fileVersionRepository(FileVersionRepositoryRef ref) {
  return FileVersionRepositoryImpl();
}

@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepositoryImpl();
}

@riverpod
DeviceRepository deviceRepository(DeviceRepositoryRef ref) {
  return DeviceRepositoryImpl();
}