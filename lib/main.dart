import 'package:chat/core/api/api_services.dart';
import 'package:chat/core/cache_helper/cache_helper.dart';
import 'package:chat/core/service_locator/service_locator.dart';
import 'package:chat/core/theme/app_themes.dart';
import 'package:chat/core/utils/app_dimensions.dart';
import 'package:chat/features/splash/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'core/localization/languages/localization.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  ServiceLocator.init();
  ApiServices.init();
  await CacheHelper.init();
  print(CacheHelper.token);
  // print(CacheHelper.userId);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashView(),
    themeMode: ThemeMode.light,
    theme: AppThemes.lightTheme,
    darkTheme: AppThemes.darkTheme,
    locale: CacheHelper.isAr == true ? Locale('ar')  : CacheHelper.isAr == false ? Locale('en') : Get.deviceLocale,
    translations: AppLanguages(),
    );
  }
}

