import 'ordered_collection.dart';

class OrderedCollectionPage<T> {
  final dynamic context;
  final String type;
  final String? next;
  final String? prev;
  final String partOf;
  final String id;
  final List<T> orderedItems;

  OrderedCollectionPage(
    this.context,
    this.type,
    this.next,
    this.prev,
    this.partOf,
    this.id,
    this.orderedItems,
  );

  OrderedCollectionPage.fromJson(Map<String, dynamic> json)
      : context = json["@context"],
        type = json["type"],
        next = json["next"],
        prev = json["prev"],
        partOf = json["partOf"],
        id = json["id"],
        orderedItems = OrderedCollection.generatePosts(json["orderedItems"]);
}
