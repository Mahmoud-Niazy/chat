import 'package:flutter/material.dart';

import '../cache_helper/cache_helper.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;

  final Color? color;

  final double? size;

  const CustomIcon(this.icon,{
    super.key,
     this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color ?? (CacheHelper.isDarkMode ? Colors.white : Colors.black38),
      size: size ?? 25,
    );
  }
}
