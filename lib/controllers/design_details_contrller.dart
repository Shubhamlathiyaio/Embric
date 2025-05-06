  import 'package:get/get.dart';

class DesignDetailController extends GetxController {
  var selectedImageIndex = 0.obs;

  void updateIndex(int index) {
    selectedImageIndex.value = index;
  }
}
