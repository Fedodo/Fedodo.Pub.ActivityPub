import 'dart:convert';
import 'package:activitypub/APIs/actor_api.dart';
import 'package:activitypub/Extensions/url_extensions.dart';
import 'package:activitypub/Models/actor.dart';
import 'package:activitypub/Models/ordered_collection_page.dart';
import 'package:activitypub/Models/ordered_paged_collection.dart';
import 'package:activitypub/config.dart';
import 'package:http/http.dart' as http;

class FollowingsAPI {
  FollowingsAPI();

  Future<OrderedPagedCollection> getFollowings(
      String followingsEndpoint) async {
    Uri followingsEndpointUri = Uri.parse(followingsEndpoint);

    if (followingsEndpointUri.authority != Config.domainName) {
      followingsEndpointUri = followingsEndpointUri.asProxyUri();
    }

    http.Response response = await http.get(
      followingsEndpointUri,
      headers: <String, String>{"Accept": "application/json"},
    );

    OrderedPagedCollection collection = OrderedPagedCollection.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
    return collection;
  }

  Future<bool> isFollowed(String followId, String actorId) async {
    ActorAPI actorAPI = ActorAPI();
    Actor actor = await actorAPI.getActor(actorId);
    Actor followActor = await actorAPI.getActor(followId);
    followId = followActor.id!;

    OrderedPagedCollection follows = await getFollowings(actor.following!);

    String url = follows.first!;

    do {
      Uri uri = Uri.parse(url);

      if (uri.authority != Config.domainName) {
        uri = uri.asProxyUri();
      }

      http.Response response = await http.get(
        uri,
        headers: <String, String>{"Accept": "application/json"},
      );

      var json = jsonDecode(utf8.decode(response.bodyBytes));

      OrderedCollectionPage collection = OrderedCollectionPage.fromJson(json);

      if (collection.orderedItems.isEmpty) {
        return false;
      }

      if (collection.orderedItems
          .where((element) => element == followId)
          .isNotEmpty) {
        return true;
      }

      url = collection.next!;
    } while (true);
  }
}
