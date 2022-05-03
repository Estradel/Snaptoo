import '../objectbox.g.dart';
import 'data_models/FoodCollectionItem.dart';
import 'data_models/ObjectCollectionItem.dart';

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  Box<FoodCollectionItem> Food() {
    return store.box<FoodCollectionItem>();
  }

  Box<ObjectCollectionItem> Object() {
    return store.box<ObjectCollectionItem>();
  }

  Box<T> GetBox<T>() => store.box<T>();

// FOR FUTURE COLLECTIONS
// Box<FlowerCollectionItem> Flower()
// {
//   return store.box<FlowerCollectionItem>();
// }
//
// Box<InsectCollectionItem> Insect()
// {
//   return store.box<InsectCollectionItem>();
// }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore();
    return ObjectBox._create(store);
  }

  void Close() {
    store.close();
  }
}
