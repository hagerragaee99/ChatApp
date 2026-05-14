import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  String generateChatId(String uid1, String uid2) {
    List<String> ids = [uid1, uid2];
    ids.sort();
    return ids.join('_');
  }

  Stream<QuerySnapshot> getMessagesStream(
    String currentUserId,
    String receiverId,
  ) {
    final chatId = generateChatId(currentUserId, receiverId);

    return _store
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('time')
        .snapshots();
  }

  Future<void> sendMessage({
    required String text,
    required String senderId,
    required String receiverId,
  }) async {
    final chatId = generateChatId(senderId, receiverId);

    await _store.collection('chats').doc(chatId).collection('messages').add({
      'text': text,
      'senderId': senderId,
      'receiverId': receiverId,
      'time': FieldValue.serverTimestamp(),
    });
  }
}
