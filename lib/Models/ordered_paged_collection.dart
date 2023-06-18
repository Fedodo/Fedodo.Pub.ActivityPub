class OrderedPagedCollection {
  final String? context;
  final String type;
  final String? first;
  final String? last;
  final int totalItems;
  final String id;

  OrderedPagedCollection(
    this.context,
    this.type,
    this.totalItems,
    this.first,
    this.last,
    this.id,
  );

  OrderedPagedCollection.fromJson(Map<String, dynamic> json)
      : context = json["@context"],
        type = json["type"],
        totalItems = json["totalItems"],
        first = json["first"],
        last = json["last"],
        id = json["id"];
}
