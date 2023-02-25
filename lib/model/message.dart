import 'package:chatapp/constant.dart';

class Message {
  final String message;
  final String id;
  const Message(this.message, this.id);

  factory Message.fromJson(jsonData) {
    return Message(jsonData[kMessage], jsonData[kId]);
  }
}
