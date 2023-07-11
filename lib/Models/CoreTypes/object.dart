class ActivityPubObject {
  final List<ActivityPubObject>? attachment;
  final String? content;
  final String? attributedTo;

  ActivityPubObject(
    this.attachment,
    this.content,
    this.attributedTo,
  );
}
