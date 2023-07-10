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
  final String content;
  final String id;
  final String type;
  final DateTime published;
  final String attributedTo;
  final Collection? replies;
  final List<Document>? attachment;

  Post(
    this.to,
    this.name,
    this.summary,
    this.sensitive,
    this.inReplyTo,
    this.content,
    this.id,
    this.type,
    this.published,
    this.attributedTo,
    this.replies,
    this.attachment,
  ) : super(attachment);

  Post.fromJson(Map<String, dynamic> json)
      : to = convertToStringList(json["to"]),
        name = json["name"],
        summary = json["summary"],
        sensitive = json["sensitive"],
        inReplyTo = json["inReplyTo"],
        content = json["content"],
        id = json["id"],
        type = json["type"],
        published = DateTime.parse(json["published"]),
        attributedTo = json["attributedTo"],
        attachment = toListOfDocuments(json["attachment"]),
        replies = json["replies"] == null
            ? null
            : Collection.fromJson(json["replies"]),
        super(json["attachment"]);

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
