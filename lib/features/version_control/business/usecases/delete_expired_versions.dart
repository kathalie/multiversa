import '../../../../core/common/business/repository_interfaces/user_repository.dart';
import '../../../../core/use_case/use_case.dart';
import '../params/delete_expired_versions_params.dart';
import '../repository_interfaces/file_version_repository.dart';

class DeleteExpiredVersionsUseCase
    implements UseCase<void, DeleteExpiredVersionsParams> {
  final IFileVersionRepository fileVersionRepository;
  final IUserRepository userRepository;

  const DeleteExpiredVersionsUseCase({
    required this.fileVersionRepository,
    required this.userRepository,
  });

  @override
  Future<void> call(DeleteExpiredVersionsParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}