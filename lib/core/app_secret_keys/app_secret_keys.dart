import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppSecretKeys {
  static String stripeSecretKey = dotenv.env['STRIPE_SECRET_KEY'] ?? '';
  static String stripePublishableKey = dotenv.env['STRIPE_PUBLISH_KEY'] ?? '';
}