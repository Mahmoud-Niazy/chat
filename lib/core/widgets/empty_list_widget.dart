import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/app_assets.dart';

class EmptyListWidget extends StatelessWidget{
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset(AppAssets.emptyList));
  }
}