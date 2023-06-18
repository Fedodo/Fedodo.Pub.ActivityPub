class Endpoints{
  final String? sharedInbox;

  Endpoints(this.sharedInbox);

  Endpoints.fromJson(Map<String, dynamic>? json)
    : sharedInbox = json?["sharedInbox"];
}