import 'dart:convert';
import 'package:activitypub/Extensions/url_extensions.dart';
import 'package:activitypub/config.dart';
import 'package:http/http.dart' as http;
import 'package:activitypub/APIs/auth_base_api.dart';
import 'package:activitypub/Models/activity.dart';
import 'package:activitypub/Models/post.dart';

class ActivityAPI {
  Future follow(Uri object) async {
    Map<String, dynamic> body = {
      "to": ["as:Public"],
      "type": "Follow",
      "object": object.toString()
    };

    String json = jsonEncode(body);

    await AuthBaseApi.post(
      url:
          Uri.parse("https://${Config.domainName}/outbox/${Config.ownActorId}"),
      body: json,
      headers: <String, String>{
        "content-type": "application/json",
      },
    );
  }

  void post(String content, String? inReplyTo) async {
    Map<String, dynamic> body = {
      "to": ["as:Public"],
      "type": "Create",
      "object": {
        "to": ["as:Public"],
        "type": "Note",
        "content": content,
        "published": DateTime.now().toUtc().toIso8601String(),
      }
    };

    if (inReplyTo != null) {
      body["object"]["inReplyTo"] = inReplyTo;
    }

    String json = jsonEncode(body);

    await AuthBaseApi.post(
      url:
          Uri.parse("https://${Config.domainName}/outbox/${Config.ownActorId}"),
      headers: <String, String>{
        "content-type": "application/json",
      },
      body: json,
    );
  }

  Future<Activity<Post>> getActivity(String activityId) async {
    Uri activityUri = Uri.parse(activityId);

    if (activityUri.authority != Config.domainName) {
      activityUri = activityUri.asProxyUri();
    }

    http.Response response = await http.get(
      activityUri,
      headers: <String, String>{
        "Accept": "application/json",
      },
    );

    Activity<Post> activity =
        Activity.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

    return activity;
  }
}
