import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:activitypub/APIs/auth_base_api.dart';
import 'package:activitypub/Models/ordered_collection_page.dart';
import 'package:activitypub/Models/ordered_paged_collection.dart';

class InboxAPI {

  Future<OrderedPagedCollection> getFirstPage(String inboxUrl) async {
    http.Response pageResponse = await http.get(Uri.parse(inboxUrl));
    OrderedPagedCollection collection =
        OrderedPagedCollection.fromJson(jsonDecode(pageResponse.body));
    return collection;
  }

  Future<OrderedCollectionPage<T>> getPosts<T>(String nextUrl) async {
    http.Response pageResponse = await AuthBaseApi.get(
      url: Uri.parse(nextUrl),
    );

    OrderedCollectionPage<T> collection = OrderedCollectionPage<T>.fromJson(jsonDecode(utf8.decode(pageResponse.bodyBytes)));

    return collection;
  }
}
