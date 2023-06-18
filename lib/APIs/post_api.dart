import 'dart:convert';

class PostAPI {
  Future<Post?> getPost(String activityId) async {
    try {
      var activityUrl = Uri.parse(activityId);

      if(activityUrl.authority != Preferences.prefs!.getString("DomainName")){
        activityUrl = activityUrl.asProxyUri();
      }

      http.Response response = await http.get(
        activityUrl,
        headers: <String, String>{"Accept": "application/json"},
      );

      Post post = Post.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      return post;
    } catch (ex) {
      return null;
    }
  }
}
