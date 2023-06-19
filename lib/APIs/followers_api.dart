import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:activitypub/Extensions/url_extensions.dart';
import 'package:activitypub/Models/ordered_paged_collection.dart';
import 'package:activitypub/config.dart';

class FollowersAPI {
  FollowersAPI();

  Future<OrderedPagedCollection> getFollowers(String followerEndpoint) async {
    Uri followerEndpointUri = Uri.parse(followerEndpoint);

    if (followerEndpointUri.authority != Config.domainName) {
      followerEndpointUri = followerEndpointUri.asProxyUri();
    }

    http.Response response = await http.get(
      followerEndpointUri,
      headers: <String, String>{"Accept": "application/json"},
    );

    OrderedPagedCollection collection = OrderedPagedCollection.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
    return collection;
  }
}
