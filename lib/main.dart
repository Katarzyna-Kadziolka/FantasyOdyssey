import 'package:fantasy_odyssey/Controllers/login_controller.dart';
import 'package:fantasy_odyssey/Pages/NavPages/main_page.dart';
import 'package:fantasy_odyssey/Pages/achievement_page.dart';
import 'package:fantasy_odyssey/Pages/history_details_list_page.dart';
import 'package:fantasy_odyssey/Pages/login_page.dart';
import 'package:fantasy_odyssey/Persistence/cache.dart';
import 'package:fantasy_odyssey/Persistence/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  runApp(const MyApp());
  await initServices();
}

Future initServices() async {
  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  await Get.putAsync(() => StorageService().init());
  Get.put(Cache());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    bool isLoggedIn = loginController.googleAccount.value == null;

    Widget homeScreen = isLoggedIn ? const MainPage() : LoginPage();

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        routes: {
          HistoryDetailsListPage.routeName: (context) =>
              const HistoryDetailsListPage(),
          AchievementPage.routeName: (context) => const AchievementPage(),
        },
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: LoginPage()
        //home: homeScreen,
        );
  }
}
