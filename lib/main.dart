// import 'package:smarty_social/routes/app_pagess.dart';
// import 'package:smarty_social/services/auth_service/auth_services.dart';
// import '../../utils/libraries/app_libraries.dart';
//
// Future<void> main() async {
//    WidgetsFlutterBinding.ensureInitialized();
//    await GetStorage.init();
//    AuthService authService=Get.put(AuthService());
//    await authService.init();
//   runApp(const MyApp());
// }
//
//
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]);
//
//     debugPrint('MyApp build method called');
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         useMaterial3: true,
//         colorScheme: const ColorScheme.dark(
//             background: Colors.white, onBackground: Colors.white),
//         primarySwatch: Colors.blue,
//         appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
//       ),
//       defaultTransition: Get.defaultTransition,
//       initialRoute: AppPages.initial,
//       getPages: AppPages.routes
//       //home: MyHomePage(),
//     );
//   }
//
// }
//
//
//
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smarty_social/routes/app_pagess.dart';
import 'package:smarty_social/services/auth_service/auth_services.dart';
import 'package:smarty_social/utils/libraries/app_libraries.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  AuthService authService = Get.put(AuthService());
  await authService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter GetX Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: AppPages.initial,
        getPages: AppPages.routes);
  }
}

class HomeController extends GetxController {
  // Add your logic here
}

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed('/details');
          },
          child: Text('Go to Details'),
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Go back'),
        ),
      ),
    );
  }
}
