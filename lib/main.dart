import 'package:chat/core/cache_helper/cache_helper.dart';
import 'package:chat/core/service_locator/service_locator.dart';
import 'package:chat/core/utils/app_dimensions.dart';
import 'package:chat/features/splash/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/localization/languages/localization.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.init();
  await CacheHelper.init();
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
    locale: CacheHelper.isAr == true ? Locale('ar')  : CacheHelper.isAr == false ? Locale('en') : Get.deviceLocale,
    translations: AppLanguages(),
    );
  }
}

