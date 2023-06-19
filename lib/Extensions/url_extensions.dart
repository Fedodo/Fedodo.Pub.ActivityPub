import 'package:activitypub/config.dart';

extension UriExtensions on Uri {
  Uri asProxyUri() {
    return Config.asProxyUri();
  }
}
