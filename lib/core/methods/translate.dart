import 'package:translator/translator.dart';

Future<String> translateEnglishToArabic(String text)async{
  final translator = GoogleTranslator();
  var translation = await translator.translate(text, to: 'ar');
  String arText = translation.text;
  return arText;
}