import 'dart:convert';
import 'package:activitypub/APIs/auth_base_api.dart';
import 'package:activitypub/Models/ordered_collection_page.dart';
import 'package:activitypub/Models/ordered_paged_collection.dart';
import 'package:activitypub/config.dart';
import 'package:http/http.dart' as http;

class SharesAPI {
  Future<OrderedPagedCollection> getShares(String postId) async {
    String formattedUrl =
        "https://${Config.domainName}/shares/${Uri.encodeQueryComponent(postId)}";

    http.Response response =
        await http.get(Uri.parse(formattedUrl), headers: <String, String>{});

    OrderedPagedCollection collection = OrderedPagedCollection.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)));
    return collection;
  }

  Future<bool> isPostShared(String postId) async {
    OrderedPagedCollection shares = await getShares(postId);

    String url = shares.first!;
    do {
      http.Response response = await http.get(
        Uri.parse(url),
      );

      OrderedCollectionPage collection = OrderedCollectionPage.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));

      if (collection.orderedItems.isEmpty) {
        return false;
      }

      if (collection.orderedItems
          .where((element) => element.actor == "https://${Config.domainName}/actor/${Config.ownActorId}")
          .isNotEmpty) {
        return true;
      }

      url = collection.next!;
    } while (true);
  }

  void share(String postId) async {
    Map<String, dynamic> body = {
      "to": ["as:Public"],
      "type": "Announce",
      "object": postId
    };

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
}
