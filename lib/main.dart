import 'package:chat/core/api/api_services.dart';
import 'package:chat/core/cache_helper/cache_helper.dart';
import 'package:chat/core/service_locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'chat_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  ServiceLocator.init();
  ApiServices.init();
  await CacheHelper.init();
  // print(CacheHelper.token);
  // print(CacheHelper.userId);
  runApp(const ChatApp());
}

/// -------------------------------------------------------------------------------------------------------- ///
///44=> 6818b21b8295050d68695cc5
///33=>6818b1628295050d68695cba

