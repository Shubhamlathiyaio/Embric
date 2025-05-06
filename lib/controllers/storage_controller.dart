import 'package:calculator/models/design_entity.dart';
import 'package:calculator/objectbox.g.dart';

import 'package:get/get.dart';
import 'package:objectbox/objectbox.dart';
class StorageController extends GetxController {
  late final Store _store;
  late final Box<DesignEntity> _designBox;

  final RxList<DesignEntity> designList = <DesignEntity>[].obs;

  Future<void> init(Store store) async {
    _store = store;
    _designBox = _store.box<DesignEntity>();
    loadDesigns(); // Load once during init
  }

  void saveDesign(DesignEntity designEntity) {
    _designBox.put(designEntity);
    loadDesigns(); // Refresh list
    print("Saved: ${designEntity.designName}"); // ✅ confirmation
  print("Total Designs: ${designList.length}"); // ✅ count check
  }

  void loadDesigns() {
    designList.value = _designBox.getAll();
  }

  DesignEntity? getDesignWithRelations(int id) {
  final design = _designBox.get(id);

  // Load ToOne relations (auto-loaded when accessed, if not null)
  design?.cPallu.target;
  design?.pallu.target;
  design?.stk.target;
  design?.blz.target;

  // Load ToMany relation (imagePaths)
  design?.imagePaths;

  return design;
}

}
