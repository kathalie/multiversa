import '../../../../core/errors/folder_exception.dart';
import '../../domain/entities/folder_entity.dart';
import '../../domain/repository_interfaces/repository.dart';
import '../../domain/types/folder_tree.dart';
import '../datasource_interfaces/datasource.dart';
import '../datasource_interfaces/text_embeddings_client.dart';
import '../dto/folder_create_dto.dart';
import '../dto/folder_update_dto.dart';
import '../translators/to_entity.dart';

class FolderRepositoryImpl implements FolderRepository {
  final FolderDataSource _folderDataSource;
  final TextEmbeddingsClient _embeddingsClient;

  FolderRepositoryImpl({
    required FolderDataSource folderDataSource,
    required TextEmbeddingsClient embeddingsClient,
  })  : _folderDataSource = folderDataSource,
        _embeddingsClient = embeddingsClient;

  @override
  Stream get folderChanges => _folderDataSource.folderChanges;

  @override
  Future<FolderTree> get folderStructure async {
    final folderDtos = await _folderDataSource.allFolders;

    final folderEntities =
        folderDtos.map((folderDto) => folderDto.toEntity()).toList();

    return FolderTree.fromList(folderEntities);
  }

  @override
  Future<FolderEntity> get rootFolder async {
    final folderDto = await _folderDataSource.rootFolder;

    return folderDto.toEntity();
  }

  @override
  Future<FolderEntity> getFolder(int id) async {
    final folderDto = await _folderDataSource.getFolder(id);

    if (folderDto == null) {
      throw FolderException.folderDoesNotExist(
        title: 'Failed to get a folder with a specified id.',
      );
    }

    return folderDto.toEntity();
  }

  @override
  Future<List<FolderEntity>> getPathToFolder(int? folderId) async {
    final folderDtos = await _folderDataSource.getPathTo(folderId);

    return folderDtos.map((folderDto) => folderDto.toEntity()).toList();
  }

  Future<String> _getPathForEmbeddings(int? parentFolderId, String name) async {
    final path = (await _folderDataSource.getPathTo(parentFolderId))
        .map((folder) => folder.name)
        .toList();
    path.removeAt(0);
    path.add(name);

    return path.join(' > ');
  }

  @override
  Future<void> createFolder(int? parentFolderId, String name) async {
    final embeddings = await _embeddingsClient.getEmbeddings(
      await _getPathForEmbeddings(parentFolderId, name),
    );

    await _folderDataSource.createFolder(
      FolderCreateDto(
        name: name,
        parentFolderId: parentFolderId,
        needsConfirmation: false,
        embeddings: embeddings,
      ),
    );
  }

  @override
  Future<void> deleteFolder(int folderId) async {
    await _folderDataSource.deleteFolderWithChildren(folderId);
  }

  @override
  Future<void> updateFolder(int folderId, String newName) async {
    final embeddings = await _embeddingsClient.getEmbeddings(
      await _getPathForEmbeddings(folderId, newName),
    );

    await _folderDataSource.updateFolder(
      FolderUpdateDto(
        id: folderId,
        name: newName,
        embeddings: embeddings,
      ),
    );
  }
}
