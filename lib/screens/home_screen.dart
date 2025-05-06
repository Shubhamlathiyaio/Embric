import 'package:calculator/controllers/nav_controller.dart'; // <- Create this file
import 'package:calculator/helpers/colors.dart';
import 'package:calculator/helpers/images.dart';
import 'package:calculator/screens/design_listview.dart';
import 'package:calculator/screens/home_view.dart';
import 'package:calculator/screens/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final navController = Get.put(NavController());

  final List<Widget> _pages = [
    DesignListview(),
    HomeView(),
    SettingView(),
  ];

  final List<ItemConfig> _items = [
    ItemConfig(
      title: "Designs",
      icon: SvgPicture.asset("${AppImage.svgIconPath}list_a.svg"),
      inactiveIcon: SvgPicture.asset("${AppImage.svgIconPath}list.svg"),
      activeForegroundColor: AppColors.redcolor,
    ),
    ItemConfig(
      title: "Home",
      icon: SvgPicture.asset("${AppImage.svgIconPath}home_a.svg"),
      inactiveIcon: SvgPicture.asset("${AppImage.svgIconPath}home.svg"),
      activeForegroundColor: AppColors.redcolor,
    ),
    ItemConfig(
      title: "Settings",
      icon: SvgPicture.asset("${AppImage.svgIconPath}settings_a.svg"),
      inactiveIcon: SvgPicture.asset("${AppImage.svgIconPath}settings.svg"),
      activeForegroundColor: AppColors.redcolor,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final index = navController.selectedIndex.value;

      return Scaffold(
        body: _pages[index],
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              final isSelected = i == index;

              return GestureDetector(
                onTap: () => navController.changeTab(i),
                child: SizedBox(
                  width: 60,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 3,
                        width: 30,
                        color: isSelected
                            ? item.activeForegroundColor
                            : Colors.transparent,
                        margin: const EdgeInsets.only(bottom: 4),
                      ),
                      isSelected ? item.icon : item.inactiveIcon,
                      const SizedBox(height: 4),
                      Text(
                        item.title ?? "",
                        style: TextStyle(
                          color: isSelected
                              ? item.activeForegroundColor
                              : Colors.grey,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      );
    });
  }
}
