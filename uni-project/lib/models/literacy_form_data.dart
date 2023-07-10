class LiteracyMessage {
  String? message;

  LiteracyMessage({this.message});
  factory LiteracyMessage.fromJson(Map<String, dynamic> json) {
    LiteracyMessage f = LiteracyMessage();
    f.message = json['message'];
    return f;
  }
}
