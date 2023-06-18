class Link{
  final String href;

  Link(this.href);

  Link.fromJson(Map<String, dynamic> json)
      : href = json["href"];
  
  static List<Link> generateLinks(json){

    if (json == null){
      return [];
    }

    List<Link> jsonList = [];

    for (var element in json) {
      jsonList.add(Link.fromJson(element));
    }

    return jsonList;
  }
}