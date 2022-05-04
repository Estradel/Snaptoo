import '../objectbox.g.dart';
import 'data_models/CollectionItem.dart';
import 'data_models/ObjectCollectionItem.dart';

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

  void addCollectionItem(CollectionItem collectionItem) {
    List<CollectionItem> yo = store
        .box<CollectionItem>()
        .query(CollectionItem_.labelName
            .equals(collectionItem.labelName)
            .and(CollectionItem_.category.equals(collectionItem.category)))
        .build()
        .find();

    if (yo.isEmpty) {
      store.box<CollectionItem>().put(collectionItem);
    } else {
      store.box<CollectionItem>().remove(yo.first.id);
      store.box<CollectionItem>().put(collectionItem);
    }
  }

  void Close() {
    store.close();
  }
}
