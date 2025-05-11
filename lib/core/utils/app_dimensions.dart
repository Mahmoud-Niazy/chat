import 'package:flutter/cupertino.dart';

abstract class AppDimensions {

  static late BuildContext _context ;

  static init(BuildContext context){
    _context = context;
  }

  static get height => MediaQuery.of(_context).size.height;

  static get width => MediaQuery.of(_context).size.width;

}