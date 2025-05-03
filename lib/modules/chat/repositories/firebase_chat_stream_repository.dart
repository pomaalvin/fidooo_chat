import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fidooo_chat/modules/chat/interfaces/chat_stream_repository.dart';
import 'package:fidooo_chat/modules/chat/models/chat.dart';
import 'package:fidooo_chat/modules/chat/models/message.dart';
import 'package:fidooo_chat/shared/services/local_storage_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FirebaseChatStreamRepository implements ChatStreamRepository{

  LocalStorageService localStorageService = Modular.get<LocalStorageService>();
  @override
  Stream<List<Chat>> getChats() {
    var user = localStorageService.getUser();
    return FirebaseFirestore.instance
        .collection('chats').orderBy('createdAt').where('user',isEqualTo: user)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Chat.fromFirestore(doc))
        .toList());
  }

  @override
  Stream<List<Message>> getMessages(String chatId) {
    var user = localStorageService.getUser();
    return FirebaseFirestore.instance
        .collection('chats').doc(chatId).collection('messages').where('user',isEqualTo: user).orderBy('createdAt',descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) {
          return Message.fromFirestore(doc);
    })
        .toList());
  }

}