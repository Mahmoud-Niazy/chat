import 'package:chat/core/utils/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/app_assets.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(AppAssets.error,width: AppDimensions.width*.7,height: AppDimensions.height*.5));
  }
}
