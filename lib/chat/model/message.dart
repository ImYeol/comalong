import 'package:comalong/utils.dart';
import "package:meta/meta.dart";

class MessageField {
  static final String createdAt = 'createdAt';
}

class Message {
  final String from;
  final String message;
  final DateTime date;

  const Message({
    @required this.from,
    @required this.message,
    @required this.date,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
        from: json['from'],
        message: json['message'],
        date: Utils.toDateTime(json['date']),
      );

  Map<String, dynamic> toJson() => {
        'from': from,
        'message': message,
        'date': Utils.fromDateTimeToJson(date),
      };
}
