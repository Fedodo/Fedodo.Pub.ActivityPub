import 'dart:core';
import 'package:activitypub/Models/ObjectTypes/document.dart';
import 'CoreTypes/object.dart';
import 'collection.dart';

class Post extends ActivityPubObject {
  final List<String> to;
  final String? name;
  final String? summary;
  final bool? sensitive;
  final String? inReplyTo;
  final String id;
  final String type;
  final DateTime published;
  final Collection? replies;

  Post(
    this.to,
    this.name,
    this.summary,
    this.sensitive,
    this.inReplyTo,
    content,
    this.id,
    this.type,
    this.published,
    attributedTo,
    this.replies,
    attachment,
  ) : super(
          attachment,
          content,
          attributedTo,
        );

  Post.fromJson(Map<String, dynamic> json)
      : to = convertToStringList(json["to"]),
        name = json["name"],
        summary = json["summary"],
        sensitive = json["sensitive"],
        inReplyTo = json["inReplyTo"],
        id = json["id"],
        type = json["type"],
        published = DateTime.parse(json["published"]),
        replies = json["replies"] == null
            ? null
            : Collection.fromJson(json["replies"]),
        super(
          json["attachment"],
          json["content"],
          json["attributedTo"],
        );

  static List<String> convertToStringList(json) {
    List<String> jsonList = [];

    for (var element in json) {
      jsonList.add(element as String);
    }

    return jsonList;
  }

  static List<Document>? toListOfDocuments(json) {
    if (json == null) {
      return null;
    }

    List<Document> documents = [];

    for (dynamic item in json) {
      documents.add(Document.fromJson(item));
    }

    return documents;
  }
}
