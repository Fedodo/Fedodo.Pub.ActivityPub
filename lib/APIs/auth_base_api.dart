import 'package:activitypub/config.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class AuthBaseApi {
  static Future<http.Response> get({
    required Uri url,
    Map<String, String>? headers,
  }) async {
    if (JwtDecoder.isExpired(Config.accessToken)) {
      await Config.refreshAccessToken();
    }

    var headersToBeSent = <String, String>{
      "Authorization": "Bearer ${Config.accessToken}",
      "Content-Type": "application/json"
    };

    if (headers != null && headers.isNotEmpty) {
      headersToBeSent.addAll(headers);
    }

    var response = http.get(
      url,
      headers: headersToBeSent,
    );

    return response;
  }

  static Future<http.Response> post({
    required Uri url,
    required String body,
    Map<String, String>? headers,
  }) async {
    if (JwtDecoder.isExpired(Config.accessToken)) {
      await Config.refreshAccessToken();
    }

    var headersToBeSent = <String, String>{
      "Authorization": "Bearer ${Config.accessToken}",
      "Content-Type": "application/json"
    };

    if (headers != null && headers.isNotEmpty) {
      headersToBeSent.addAll(headers);
    }

    var response = await http.post(
      url,
      headers: headersToBeSent,
      body: body,
    );

    return response;
  }
}
