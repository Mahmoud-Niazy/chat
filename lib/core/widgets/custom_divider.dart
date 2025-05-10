import 'package:flutter/material.dart';

import '../cache_helper/cache_helper.dart';

class CustomDivider extends StatelessWidget{
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 15,
      ),
      child: Divider(
        color: CacheHelper.isDarkMode ? Colors.grey : Colors.black12,
      ),
    );
  }

}