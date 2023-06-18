import 'package:activitypub/Models/post.dart';

class Activity<T> {
  Object? context;
  List<String>? to;
  List<String>? bto;
  List<String>? cc;
  List<String>? bcc;
  List<String>? audience;
  T object;
  String id;
  String type;
  DateTime? published;
  String actor;

  Activity(
    this.to,
    this.object,
    this.id,
    this.type,
    this.published,
    this.actor,
    this.context,
    this.bto,
    this.cc,
    this.bcc,
    this.audience,
  );

  Activity.fromJson(Map<String, dynamic> json)
      : context = json["context"],
        to = convertToStringList(json["to"]),
        bto = convertToStringList(json["bto"]),
        cc = convertToStringList(json["cc"]),
        bcc = convertToStringList(json["bcc"]),
        audience = convertToStringList(json["audience"]),
        object = generateObject<T>(json["object"]),
        id = json["id"],
        type = json["type"],
        published = DateTime.parse(json["published"]),
        actor = json["actor"];

  static generateObject<T>(object) {
    if (T == Post) {
      return Post.fromJson(object);
    } else if (T == String) {
      return object as String;
    } else if (object["type"] == "Note") {
      return Post.fromJson(object);
    } else {
      return null;
    }
  }

  static List<String>? convertToStringList(json) {
    if (json == null) {
      return null;
    }

    List<String> jsonList = [];

    for (var element in json) {
      jsonList.add(element as String);
    }

    return jsonList;
  }
}
