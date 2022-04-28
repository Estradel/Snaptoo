import '../objectbox.g.dart';
import 'DataModels/FoodCollectionItem.dart';

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

  Box<FoodCollectionItem> Food()
  {
    return store.box<FoodCollectionItem>();
  }

  // FOR FUTURE COLLECTIONS
  // Box<ObjectCollectionItem> Object()
  // {
  //   return store.box<ObjectCollectionItem>();
  // }
  //
  // Box<FlowerCollectionItem> Flower()
  // {
  //   return store.box<FlowerCollectionItem>();
  // }
  //
  // Box<InsectCollectionItem> Insect()
  // {
  //   return store.box<InsectCollectionItem>();
  // }

  void Close()
  {
    store.close();
  }
}