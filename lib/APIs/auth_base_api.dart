import 'dart:io';

class AuthBaseApi {
  static LoginManager loginManager =
      LoginManager(!kIsWeb && Platform.isAndroid);

  static Future<Response> get({
    required Uri url,
    Map<String, String>? headers,
  }) async {
    if (JwtDecoder.isExpired(Preferences.prefs!.getString("AccessToken")!)) {
      await loginManager.refresh(Preferences.prefs!.getString("ClientId")!,
          Preferences.prefs!.getString("ClientSecret")!);
    }

    var headersToBeSent = <String, String>{
      "Authorization": "Bearer ${Preferences.prefs!.getString("AccessToken")}",
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

  static Future<Response> post({
    required Uri url,
    required String body,
    Map<String, String>? headers,
  }) async {
    if (JwtDecoder.isExpired(Preferences.prefs!.getString("AccessToken")!)) {
      loginManager.refresh(Preferences.prefs!.getString("ClientId")!,
          Preferences.prefs!.getString("ClientSecret")!);
    }

    var headersToBeSent = <String, String>{
      "Authorization": "Bearer ${Preferences.prefs!.getString("AccessToken")}",
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
