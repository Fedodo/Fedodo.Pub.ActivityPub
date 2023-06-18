class PublicKey {
  final String? id;
  final String? owner;
  final String? publicKeyPem;

  PublicKey(this.id, this.owner, this.publicKeyPem);

  PublicKey.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        owner = json["owner"],
        publicKeyPem = json["publicKeyPem"];
}
