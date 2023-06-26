import 'dart:convert';
import 'package:activitypub/Extensions/url_extensions.dart';
import 'package:http/http.dart' as http;

class WebfingerApi {
  Future<String> getUser(String fullUserName) async {
    String domain = fullUserName.split("@")[1];

    var resp = await http.get(Uri.parse(
            "https://$domain/.well-known/webfinger?resource=acct:$fullUserName")
        .asProxyUri());

    var result = jsonDecode(resp.body);
    var links = result["links"];
    var profileId = links.first["href"];

    return profileId;
  }
}
