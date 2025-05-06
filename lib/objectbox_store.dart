import 'package:calculator/objectbox.g.dart';

class ObjectBoxStore {
  late final Store store;

  ObjectBoxStore._create(this.store);

  static Future<ObjectBoxStore> init() async {
    final store = await openStore();
    return ObjectBoxStore._create(store);
  }

  void close() {
    store.close();
  }
}
