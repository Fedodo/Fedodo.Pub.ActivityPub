import 'dart:convert';
import 'package:activitypub/Models/ordered_paged_collection.dart';

class SharesAPI {
  Future<OrderedPagedCollection> getShares(String postId) async {
    String formattedUrl =
        "https://${Preferences.prefs!.getString("DomainName")}/shares/${Uri.encodeQueryComponent(postId)}";

    http.Response response =
        await http.get(Uri.parse(formattedUrl), headers: <String, String>{});

    OrderedPagedCollection collection = OrderedPagedCollection.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    return collection;
  }

  Future<bool> isPostShared(String postId) async {
    OrderedPagedCollection shares = await getShares(postId);

    String url = shares.first!;
    do {
      http.Response response = await http.get(
        Uri.parse(url),
      );

      OrderedCollectionPage collection = OrderedCollectionPage.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      if (collection.orderedItems.isEmpty) {
        return false;
      }

      if (collection.orderedItems
          .where((element) => element.actor == General.fullActorId)
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
      url: Uri.parse("https://${Preferences.prefs!.getString("DomainName")}/outbox/${General.actorId}"),
      headers: <String, String>{
        "content-type": "application/json",
      },
      body: json,
    );
  }
}
