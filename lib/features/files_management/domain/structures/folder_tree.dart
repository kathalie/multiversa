import 'package:collection/collection.dart';

import '../../../../core/common/const.dart';
import '../entities/folder_entity.dart';

typedef FolderTreeStructure = List<FolderTree>;

class FolderTree {
  final FolderEntity folder;
  final List<FolderTree> children;

  FolderTree({
    required this.folder,
    required this.children,
  });

  static FolderTreeStructure fromList(List<FolderEntity> folders) {
    final foldersByParentId = groupBy<FolderEntity, int?>(
      folders,
      (folder) => folder.parentId,
    );

    final List<FolderEntity> rootFolders = folders
        .where((folder) => folder.parentId == rootFolderId)
        .toList();

    return rootFolders.map((rootFolder) {
      return _buildTree(rootFolder, foldersByParentId);
    }).toList();
  }

  static FolderTree _buildTree(
    FolderEntity folder,
    Map<int?, List<FolderEntity>> foldersByParentId,
  ) {
    final List<FolderTree> children = [];
    final childFolders = foldersByParentId[folder.id] ?? [];

    childFolders.sort((a, b) => a.name.compareTo(b.name));

    for (final childFolder in childFolders) {
      children.add(_buildTree(childFolder, foldersByParentId));
    }

    return FolderTree(
      folder: folder,
      children: children,
    );
  }
}
