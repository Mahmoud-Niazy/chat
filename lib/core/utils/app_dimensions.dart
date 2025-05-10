import 'package:flutter/cupertino.dart';

abstract class AppDimensions {

  static late BuildContext _context ;

  static init(BuildContext context){
    _context = context;
  }

  static get screenHeight => MediaQuery.of(_context).size.height;

  static get screenWidth => MediaQuery.of(_context).size.width;

}