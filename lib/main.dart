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

import 'package:smarty_social/routes/app_pagess.dart';
import 'package:smarty_social/services/auth_service/auth_services.dart';
import 'package:smarty_social/utils/libraries/app_libraries.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();

  runApp(const MyApp());
}

Future<void> initServices() async {
  await GetStorage.init();
  // bio
  AuthService auth = AuthService();
  await Get.putAsync(() => auth.init());
  // await Get.putAsync(() => bio.init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme.dark(
              background: Colors.white, onBackground: Colors.white),
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        ),
        title: '',
        defaultTransition: Get.defaultTransition,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes);
  }
}
