import 'dart:convert';

class ActivityAPI {

  Future follow(Uri object) async {

    Map<String, dynamic> body = {
      "to": ["as:Public"],
      "type": "Follow",
      "object": object.toString()
    };

    String json = jsonEncode(body);

    await AuthBaseApi.post(
      url: Uri.parse("https://${Preferences.prefs!.getString("DomainName")}/outbox/${General.actorId}"),
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
      url: Uri.parse("https://${Preferences.prefs!.getString("DomainName")}/outbox/${General.actorId}"),
      headers: <String, String>{
        "content-type": "application/json",
      },
      body: json,
    );
  }

  Future<Activity<Post>> getActivity(String activityId) async {

    Uri activityUri = Uri.parse(activityId);

    if(activityUri.authority != Preferences.prefs!.getString("DomainName")){
      activityUri = activityUri.asProxyUri();
    }

    http.Response response = await http.get(
      activityUri,
      headers: <String, String>{
        "Accept": "application/json",
      },
    );

    Activity<Post> activity = Activity.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

    return activity;
  }
}
