import 'package:calculator/controllers/design_controller.dart';
import 'package:calculator/controllers/design_data_controller.dart';
import 'package:calculator/controllers/design_form_controller.dart';
import 'package:calculator/controllers/storage_controller.dart';
import 'package:calculator/objectbox_store.dart';
import 'package:calculator/screens/design_detail_view.dart';
import 'package:calculator/screens/home_screen.dart';
import 'package:calculator/screens/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'controllers/lang_controller.dart';
import 'helpers/app_constant.dart';
import 'helpers/dependency_intl.dart' as dep;
import 'helpers/messages.dart';

Future<void> main() async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  WidgetsFlutterBinding.ensureInitialized();
  final objectBox = await ObjectBoxStore.init();

  await _initlizer(objectBox);

  Map<String, Map<String, String>> languages = await dep.init();

  runApp(MyApp(languages: languages));
}

Future<void> _initlizer(ObjectBoxStore objectBox) async {
  // ✅ Put StorageController first
  final storage = Get.put(StorageController());
  await storage.init(objectBox.store);

  Get.put(DesignFormController());
  Get.put(DesignDataController());
  Get.put(DesignController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.languages});
  final Map<String, Map<String, String>> languages;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
    return GetBuilder<LocalizationController>(
        builder: (localizationController) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        locale: localizationController.locale,
        translations: Messages(languages: languages),
        fallbackLocale: Locale(AppConstants.languages[0].languageCode,
            AppConstants.languages[0].countryCode),
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => SplashScreen()),
          GetPage(name: '/home', page: () => HomeScreen()),
          GetPage(name: '/design_list/design_view', page: () => DesignDetailView()),
        ],
      );
    });
  }
}
