import 'package:chat/core/utils/app_dimensions.dart';
import 'package:chat/features/splash/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return MaterialApp(
    home: SplashView(),
    );
  }
}

