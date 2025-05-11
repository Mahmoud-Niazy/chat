import 'package:flutter/material.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_dimensions.dart';

class AppLogo extends StatelessWidget{
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return  Hero(
      tag: 'logo',
      child: Center(
        child: Image.asset(
          AppAssets.logo,
          height: AppDimensions.height * .15,
        ),
      ),
    );
  }
}