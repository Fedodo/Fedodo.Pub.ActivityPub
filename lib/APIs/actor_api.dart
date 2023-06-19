import 'dart:convert';
import 'package:activitypub/APIs/auth_base_api.dart';
import 'package:activitypub/Extensions/url_extensions.dart';
import 'package:activitypub/Models/actor.dart';
import 'package:activitypub/config.dart';
import 'package:http/http.dart' as http;

class ActorAPI {
  Future<List<String>> getAllActorsOfUser(String userId) async {
    var domainName = Config.domainName;

    var response = await AuthBaseApi.get(
        url: Uri.parse("https://auth.$domainName/user/actors?userid=$userId"));

    var json = jsonDecode(response.body);

    List<String> result = List<String>.from(json);

    return result;
  }

  Future createActor(String userId, String name, String? summary) async {
    var domainName = Config.domainName;

    Map<String, dynamic> bodyMap = {
      "type": "Person",
      "name": name,
      "preferredUsername": name,
      "summary": summary,
    };

    String body = jsonEncode(bodyMap);
    await AuthBaseApi.post(
        url: Uri.parse("https://auth.$domainName/user/actors?userid=$userId"),
        body: body);
  }

  Future<Actor> getActor(String actorId) async {
    var actorUri = Uri.parse(actorId);

    if (actorUri.authority != Config.domainName) {
      actorUri = actorUri.asProxyUri();
    }

    http.Response response = await http.get(
      actorUri,
      headers: <String, String>{
        "Accept": "application/json",
      },
    );

    String utf8String = utf8.decode(response.bodyBytes);

    Actor actor = Actor.fromJson(jsonDecode(utf8String));

    return actor;
  }
}
