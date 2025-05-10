import 'package:get/get.dart';
import 'ar.dart';
import 'en.dart';

class AppLanguages extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    'ar': arabicLanguage,
    'en': englishLanguage,
  };

}