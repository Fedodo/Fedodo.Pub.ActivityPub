class Media{
  final String type;
  final String mediaType;
  final String url;

  Media(this.type, this.mediaType, this.url);

  Media.fromJson(Map<String, dynamic> json)
    : type = json["type"],
      mediaType = json["mediaType"],
      url = json["url"];

}