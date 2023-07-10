import 'package:activitypub/Models/CoreTypes/object.dart';

class Document extends ActivityPubObject {
  final String type;
  final String? name;
  final String? mediaType;
  final String? context;
  final Uri? url;

  Document(
    this.type,
    this.name,
    this.mediaType,
    this.context,
    this.url,
  ) : super(null);

  Document.fromJson(Map<String, dynamic> json)
      : type = json["type"],
        mediaType = json["mediaType"],
        url = Uri.tryParse(json["url"]),
        name = json["name"],
        context = json["@context"],
        super(null);
}
