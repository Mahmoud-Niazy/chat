import 'package:flutter/material.dart';
import '../../../../../core/google_auth_service/google_auth_service.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_dimensions.dart';

class SignWithGoogleIcon extends StatelessWidget{
  const SignWithGoogleIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: InkWell(
        onTap: ()async{
          await GoogleAuthService().signInWithGoogle();
        },
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
            ),
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            height: AppDimensions.height *.04,
            AppAssets.google,
          ),
        ),
      ),
    );
  }
}