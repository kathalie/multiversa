import '../entities/collection_entity.dart';
import '../repository_interfaces/collection_repository.dart';

class CreateCollectionUseCase {
  final CollectionRepository collectionRepository;

  const CreateCollectionUseCase({
    required this.collectionRepository,
  });

  Future<void> call({
    required CollectionEntity newCollectionEntity,
    required String parentCollectionId,
  }) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
