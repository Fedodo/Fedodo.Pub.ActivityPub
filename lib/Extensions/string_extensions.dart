import 'package:activitypub/config.dart';

extension StringExtensions on String{
  String asProxyString() {
    return Config.asProxyString(this);
  }
}