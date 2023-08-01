import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:activitypub/Extensions/url_extensions.dart';
import 'package:activitypub/Models/ordered_collection_page.dart';
import 'package:activitypub/Models/ordered_paged_collection.dart';
import 'package:activitypub/config.dart';

class OutboxAPI {
  Future<OrderedPagedCollection> getFirstPage(String outboxUrl) async {
    Config.logger.v("Getting first page with outboxUrl=$outboxUrl");

    Uri outboxUri = Uri.parse(outboxUrl);

    if (outboxUri.authority != Config.domainName) {
      outboxUri = outboxUri.asProxyUri();
    }

    http.Response pageResponse = await http.get(
      outboxUri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    Config.logger.d("Response-Headers: ${pageResponse.headers}");

    OrderedPagedCollection collection = OrderedPagedCollection.fromJson(
        jsonDecode(utf8.decode(pageResponse.bodyBytes)));

    Config.logger.v("Returning collection");

    return collection;
  }

  Future<OrderedCollectionPage<T>> getPosts<T>(String nextUrl) async {
    Uri nextUri = Uri.parse(nextUrl);

    if (nextUri.authority != Config.domainName) {
      nextUri = nextUri.asProxyUri();
    }

    http.Response pageResponse = await http.get(nextUri);

    OrderedCollectionPage<T> collection = OrderedCollectionPage<T>.fromJson(
        jsonDecode(utf8.decode(pageResponse.bodyBytes)));

    return collection;
  }
}
