import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../cache_helper/cache_helper.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_keys.dart';

class LocalizationController extends GetxController{

  int currentIndex = CacheHelper.isAr == true ? 1 : CacheHelper.isAr == false ? 0 : (Get.deviceLocale == Locale('ar') ) ? 1 : 0;

  List<LanguageItemModel> languages = [
    LanguageItemModel(
      languageEName: "English",
      flag: AppAssets.englandFlag,
      languageAName: "اللغة الانجليزية",
      languageCode: 'en'
    ),
    LanguageItemModel(
      languageEName: "Arabic",
      flag: AppAssets.egyptFlag,
      languageAName: "العربية",
      languageCode: 'ar'
    ),
  ];

  Future<void> changeLang(String langCode)async{
    Locale locale = Locale(langCode);
    if(langCode.contains('ar')){
      CacheHelper.saveData(key: AppKeys.isAr, value: true);
      currentIndex = 1;
    }
    else{
      CacheHelper.saveData(key: AppKeys.isAr, value: false);
      currentIndex = 0;
    }
    await Get.updateLocale(locale);
    update();
  }
}

class LanguageItemModel {
  final String flag;
  final String languageEName;
  final String languageAName ;
  final String languageCode;

  LanguageItemModel({
    required this.languageEName,
    required this.flag,
    required this.languageAName,
    required this.languageCode
  });

}