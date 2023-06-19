import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:activitypub/Extensions/url_extensions.dart';
import 'package:activitypub/Models/post.dart';
import 'package:activitypub/config.dart';

class PostAPI {
  Future<Post?> getPost(String activityId) async {
    try {
      var activityUrl = Uri.parse(activityId);

      if (activityUrl.authority != Config.domainName) {
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
