import '../../../version_control/business/repository_interfaces/file_version_repository.dart';
import '../../business/entities/file_entity.dart';
import '../../business/repository_interfaces/file_repository.dart';
import '../data_source_interfaces/file_data_source.dart';
import '../models/file_model.dart';

class FileRepositoryImpl implements FileRepository {
  final FileVersionRepository fileVersionRepository;
  final FileDataSource fileDataSource;

  const FileRepositoryImpl({
    required this.fileVersionRepository,
    required this.fileDataSource,
  });

  Future<FileEntity> _toEntity(File model) async {
    final allVersionIds = model.allFileVersions.map(
      (model) => model.id.toString(),
    );

    final currentFileVersionEntity = await fileVersionRepository.getFileVersion(
      model.currentFileVersion.value!.id.toString(),
    );

    return FileEntity(
      id: model.id.toString(),
      name: model.name,
      timeCreated: model.timeCreated,
      currentFileVersionId: model.currentFileVersion.value!.id.toString(),
      allVersionIds: allVersionIds.toList(),
      location: currentFileVersionEntity.location,
      // TODO organize locations
      content: currentFileVersionEntity.content, // TODO read from storage
    );
  }

  @override
  Future<void> createFile({
    required String name,
    required DateTime dateCreated,
    required String currentFileVersionId,
  }) async {
    fileDataSource.createFile(
      name: name,
      dateCreated: dateCreated,
      currentFileVersionId: currentFileVersionId,
    );
  }

  @override
  Future<void> deleteFile(String fileId) {
    return fileDataSource.deleteFile(fileId);
  }

  @override
  Future<FileEntity> getFile(String fileId) async {
    final file = await fileDataSource.getFile(fileId);

    return _toEntity(file);
  }

  @override
  Future<List<FileEntity>> getFilesFromCollection(String collectionId) async {
    final files = await fileDataSource.getFilesFromCollection(collectionId);

    return await Future.wait(files.map((model) => _toEntity(model)).toList());
  }

  @override
  Future<void> updateFile({
    required String id,
    String? name,
    String? currentFileVersion,
  }) async {
    await fileDataSource.updateFile(
      id: id,
      name: name,
      currentFileVersion: currentFileVersion,
    );
  }
}
