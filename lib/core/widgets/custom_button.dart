import 'package:flutter/material.dart';

import '../utils/app_constance.dart';
import '../utils/app_styles.dart';
import 'custom_circular_button.dart';

class CustomButton extends StatelessWidget {
  final Color backgroundColor;

  final String title;
  final void Function()? onPressed;
  final bool ?isCircularButton ;
  final bool isLoading ;

  const CustomButton({
    super.key,
    required this.backgroundColor,
    required this.title,
    required this.onPressed, this.isCircularButton = true,
    this.isLoading =false
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
      height: 60,
      child: isLoading ?  const SizedBox(
        height: 24,
        width: 24,
        child:  CircularProgressIndicator(
          color: Colors.white,
        ),
      ): Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppStyles.style17.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          if(isCircularButton ==true)
            CustomCircularButton(
              backgroundColor: Colors.white,
              icon: Icons.arrow_forward,
              onPressed: onPressed,
              iconColor: AppConstance.primaryColor,
              height: 35,
            ),
        ],
      ),
    );
  }
}
