import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:im/core/models/user.dart';
import 'package:im/core/models/conversation.dart';
import 'package:im/core/models/message.dart';

// Mock Data
final kUser1 = User(id: '1', name: 'Alice', avatarUrl: 'https://api.dicebear.com/7.x/avataaars/png?seed=Alice');
final kUser2 = User(id: '2', name: 'Bob', avatarUrl: 'https://api.dicebear.com/7.x/avataaars/png?seed=Bob');
final kUser3 = User(id: '3', name: 'Charlie', avatarUrl: 'https://api.dicebear.com/7.x/avataaars/png?seed=Charlie');
final kCurrentUser = kUser1;

final kConversations = [
  Conversation(
    id: 'c1',
    participants: [kUser2],
    lastMessage: Message(
      id: 'm1',
      senderId: '2',
      content: 'Hey, how are you?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
  ),
  Conversation(
    id: 'c2',
    participants: [kUser3],
    lastMessage: Message(
      id: 'm2',
      senderId: '1',
      content: 'See you tomorrow!',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
  ),
];

// Auth Provider
class AuthNotifier extends Notifier<User?> {
  @override
  User? build() => null;

  void login() {
    state = kCurrentUser;
  }

  void logout() {
    state = null;
  }
}

final authProvider = NotifierProvider<AuthNotifier, User?>(AuthNotifier.new);

// Data Providers
final conversationsProvider = Provider<List<Conversation>>((ref) {
  return kConversations;
});

final chatMessagesProvider = NotifierProvider.family<ChatNotifier, List<Message>, String>(ChatNotifier.new);

class ChatNotifier extends FamilyNotifier<List<Message>, String> {
  @override
  List<Message> build(String arg) {
    return [
      // Initial mock messages
      Message(
        id: '${arg}_1',
        senderId: '2',
        content: 'Hello!',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Message(
        id: '${arg}_2',
        senderId: '1',
        content: 'Hi there!',
        timestamp: DateTime.now().subtract(const Duration(hours: 20)),
      ),
    ];
  }

  void sendMessage(String content, String senderId) {
    state = [
      ...state,
      Message(
        id: DateTime.now().toString(),
        senderId: senderId,
        content: content,
        timestamp: DateTime.now(),
      ),
    ];
  }
}
