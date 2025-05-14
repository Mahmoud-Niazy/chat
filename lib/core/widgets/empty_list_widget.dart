import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/app_assets.dart';
import '../utils/app_dimensions.dart';

class EmptyListWidget extends StatelessWidget{
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(AppAssets.emptyList,width: AppDimensions.width*.7,height: AppDimensions.height*.5));
  }
}