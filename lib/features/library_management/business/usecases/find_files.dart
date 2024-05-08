import '../../../../core/common/business/entities/file_entity.dart';
import '../../../../core/common/business/repository_interfaces/file_repository.dart';
import '../../../../core/use_case/use_case.dart';
import '../params/find_files_params.dart';

class FindFilesUseCase implements UseCase<List<FileEntity>, FindFilesParams> {
  final IFileRepository fileRepository;

  const FindFilesUseCase({
    required this.fileRepository,
  });

  @override
  Future<List<FileEntity>> call(FindFilesParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}