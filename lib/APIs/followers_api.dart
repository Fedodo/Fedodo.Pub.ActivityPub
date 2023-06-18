import 'dart:convert';

class FollowersAPI {
  FollowersAPI();

  Future<OrderedPagedCollection> getFollowers(String followerEndpoint) async {

    Uri followerEndpointUri = Uri.parse(followerEndpoint);

    if(followerEndpointUri.authority != Preferences.prefs!.getString("DomainName")){
      followerEndpointUri = followerEndpointUri.asProxyUri();
    }

    http.Response response = await http.get(
      followerEndpointUri,
      headers: <String, String>{
        "Accept": "application/json"
      },
    );

    OrderedPagedCollection collection = OrderedPagedCollection.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    return collection;
  }
}
