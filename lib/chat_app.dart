import 'package:flutter/material.dart';
import 'core/cache_helper/cache_helper.dart';
import 'core/localization/languages/localization.dart';
import 'core/theme/app_themes.dart';
import 'core/utils/app_dimensions.dart';
import 'features/splash/presentation/view/splash_view.dart';
import 'package:get/get.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});
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