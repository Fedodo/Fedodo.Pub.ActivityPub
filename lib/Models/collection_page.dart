class CollectionPage{
  final dynamic context;
  final String type;
  final String? next;
  final String? prev;
  final String? partOf;
  final String? id;
  final List<String> items;

  CollectionPage(
      this.context,
      this.type,
      this.next,
      this.prev,
      this.partOf,
      this.id,
      this.items,
      );

  CollectionPage.fromJson(Map<String, dynamic> json)
      : context = json["@context"],
        type = json["type"],
        next = json["next"],
        prev = json["prev"],
        partOf = json["partOf"],
        id = json["id"],
        items = json["items"];
}