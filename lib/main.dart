import 'package:get_storage/get_storage.dart';
import 'package:smarty_social/routes/app_pagess.dart';
import 'package:smarty_social/services/auth_service/auth_services.dart';

import 'utils/libraries/app_libraries.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  FlutterError.onError = (FlutterErrorDetails details) {
    print("====================$details");

    // Log or handle the error details
  };

  runApp(const MyApp());
}

Future<void> initServices() async {
  await GetStorage.init();

  // final storage=GetStorage();
  // storage.remove("isAppOpen");
  // bio
  AuthService auth = AuthService();
  await Get.putAsync(() => auth.init());
  // await Get.putAsync(() => bio.init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    debugPrint('MyApp build method called');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
            background: Colors.white, onBackground: Colors.white),
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
      ),
      defaultTransition: Get.defaultTransition,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      //home: MyHomePage(),
    );
  }
}
