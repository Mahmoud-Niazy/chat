import 'package:chat/core/methods/translate.dart';
import 'package:flutter/material.dart';

import '../cache_helper/cache_helper.dart';

void showSnackBar({
  required BuildContext context,
  required String label,
  required Color color ,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        label,
      ),
      backgroundColor: color,
    ),
  );
}

Future<void> showErrorSnackBar(BuildContext context, String error)async{
  showSnackBar(
    context: context,
    label: CacheHelper.isAr != false
        ? await translateEnglishToArabic(error)
        : error,
    color: Colors.red,
  );
}


