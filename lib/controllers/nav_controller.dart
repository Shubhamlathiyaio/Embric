import 'package:get/get.dart';

class NavController extends GetxController {
  var selectedIndex = 1.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
