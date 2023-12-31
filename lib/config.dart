import 'package:logger/logger.dart';

class Config {
  static String? _accessToken;
  static String get accessToken {
    if (_accessToken == null || _accessToken!.isEmpty) {
      throw ArgumentError("Access Token must be set!");
    }

    return _accessToken!;
  }

  static set accessToken(var value) => _accessToken = value;

  static String? _domainName;
  static String get domainName {
    if (_domainName == null || _domainName!.isEmpty) {
      throw ArgumentError("domainName must be set!");
    }

    return _domainName!;
  }

  static set domainName(var value) => _domainName = value;

  static String? _ownActorId;
  static String get ownActorId {
    if (_ownActorId == null || _ownActorId!.isEmpty) {
      throw ArgumentError("ownActorId must be set!");
    }

    return _ownActorId!;
  }

  static set ownActorId(var value) => _ownActorId = value;

  static Function? _refreshAccessToken;
  static Function get refreshAccessToken {
    if (_refreshAccessToken == null) {
      throw ArgumentError("RefreshAccessToken must be set!");
    }

    return _refreshAccessToken!;
  }

  static set refreshAccessToken(var value) => _refreshAccessToken = value;

  static Function(String)? _asProxyString;
  static Function(String) get asProxyString {
    if (_asProxyString == null) {
      throw ArgumentError("asProxyString must be set!");
    }

    return _asProxyString!;
  }

  static set asProxyString(var value) => _asProxyString = value;

  static Function(Uri)? _asProxyUri;
  static Function(Uri) get asProxyUri {
    if (_asProxyUri == null) {
      throw ArgumentError("asProxyUri must be set!");
    }

    return _asProxyUri!;
  }

  static set asProxyUri(var value) => _asProxyUri = value;

  static Logger? _logger;
  static Logger get logger {
    if (_logger == null) {
      throw ArgumentError("logger must be set!");
    }

    return _logger!;
  }

  static set logger(var value) => _logger = value;
}
