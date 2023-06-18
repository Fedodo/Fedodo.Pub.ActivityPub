import 'package:activitypub/Models/post.dart';

import 'activity.dart';

class OrderedCollection {
  final String? context;
  final String? summary;
  final String type;
  final int totalItems;
  final List<Activity> orderedItems;

  OrderedCollection(this.context, this.summary, this.type, this.totalItems,
      this.orderedItems);

  OrderedCollection.fromJson(Map<String, dynamic> json)
      : context = json["@context"],
        summary = json["summary"],
        type = json["type"],
        totalItems = json["totalItems"],
        orderedItems = generatePosts(json["orderedItems"]);

  static List<T> generatePosts<T>(json) {

    if (json == null){
      return [];
    }

    var list = json as List;
    List<T> returnList = [];

    for (dynamic element in list) {
      if (element is String){
        returnList.add(element as T);
      }
      else if (element["type"] == "Create"){
        returnList.add(Activity<Post>.fromJson(element) as T);
      }else if (element["type"] == "Announce" || element["type"] == "Like"){
        returnList.add(Activity<String>.fromJson(element) as T);
      }else if (element["type"] == "Follow"){
        returnList.add(element["object"]);
      }
    }

    return returnList;
  }
}
