
import 'package:json_annotation/json_annotation.dart';
import 'message.dart';
import 'user.dart';

part 'conversation.g.dart';

@JsonSerializable()
class Conversation {
  final String id;
  final List<User> participants;
  final Message? lastMessage;

  const Conversation({
    required this.id,
    required this.participants,
    this.lastMessage,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}
