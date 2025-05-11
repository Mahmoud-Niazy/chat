import 'package:chat/core/utils/app_dimensions.dart';
import 'package:chat/features/auth/presentation/views/login_view.dart';
import 'package:flutter/material.dart';
import '../../../../core/methods/navigation.dart';
import '../../../../core/utils/app_assets.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () {
        navigateAndRemoveUntil(
          context: context,
          // screen: OnBoardingView(),
          screen: LoginView(),
          // CacheHelper.token != null ? const LayoutView() : const OnBoardingView(),

        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppAssets.logo,
          width: AppDimensions.width*.3,
          height: AppDimensions.height * .3,
        ),
      ),
    );
  }
}
