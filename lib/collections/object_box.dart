import '../objectbox.g.dart';
import 'data_models/collection_item.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore();
    return ObjectBox._create(store);
  }

  List<CollectionItem> getCollectionItems() {
    return store.box<CollectionItem>().getAll();
  }

  bool checkExistsAlready(String labelName, String category) {
    List<CollectionItem> item = store
        .box<CollectionItem>()
        .query(CollectionItem_.labelName
            .equals(labelName)
            .and(CollectionItem_.category.equals(category)))
        .build()
        .find();

    return item.isNotEmpty;
  }

  List<CollectionItem> doesItemAlreadyExists(CollectionItem collectionItem) {
    return store
        .box<CollectionItem>()
        .query(CollectionItem_.labelName
            .equals(collectionItem.labelName)
            .and(CollectionItem_.category.equals(collectionItem.category)))
        .build()
        .find();
  }

  void addCollectionItem(CollectionItem collectionItem) {
    var item = doesItemAlreadyExists(collectionItem);
    if (item.isEmpty) {
      store.box<CollectionItem>().put(collectionItem);
    } else {
      store.box<CollectionItem>().remove(item.first.id);
      store.box<CollectionItem>().put(collectionItem);
    }
  }

  void Close() {
    store.close();
  }
}
