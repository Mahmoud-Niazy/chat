import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/app_constance.dart';
import '../utils/app_styles.dart';

//ignore: must_be_immutable
class CustomUnderLineTextFieldWith extends StatefulWidget{
  final String label ;
  final TextEditingController controller ;
  // final String? Function(String?)? validate;
  bool isPassword ;
  bool isSuffixIconShown ;
  TextInputType? type ;

  CustomUnderLineTextFieldWith({super.key,
    required this.label,
    required this.controller,
    // required this.validate,
    this.isPassword = false,
    this.isSuffixIconShown = false,
    this.type,
  });

  @override
  State<CustomUnderLineTextFieldWith> createState() => _CustomUnderLineTextFieldWithState();
}

class _CustomUnderLineTextFieldWithState extends State<CustomUnderLineTextFieldWith> {
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      style: TextStyle(fontSize: 13),
      keyboardType: widget.type,
      validator: (String? value){
      if (value!.isEmpty) {
        return '${'please_enter_your'.tr} ${widget.label}';
      }
      return null;
    },
      controller: widget.controller,
      obscureText: widget.isPassword,
      cursorColor: AppConstance.primaryColor,
      decoration: InputDecoration(

        suffixIcon: widget.isSuffixIconShown ? GestureDetector(
          onTap: (){
            setState(() {
              widget.isPassword = !widget.isPassword;
            });
          },
          child: Icon(
              widget.isPassword? Icons.visibility_off_outlined : Icons.remove_red_eye_outlined
          ),
        ) : null,
        hintText: widget.label,
        hintStyle: AppStyles.style15Grey.copyWith(
          color: Colors.blueGrey,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppConstance.primaryColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppConstance.primaryColor,
          ),
        ),
      ),
    );
  }
}