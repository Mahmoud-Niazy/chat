import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/app_constance.dart';

class CustomCircularProgressIndicator extends StatelessWidget{
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: CircularProgressIndicator(
          backgroundColor: AppConstance.primaryColor,
        ),
      ),
    );
  }
}