import 'package:fidooo_chat/modules/chat/models/chat.dart';
import 'package:fidooo_chat/modules/chat/models/message.dart';

abstract class ChatStreamRepository{

  Stream<List<Chat>> getChats();
  Stream<List<Message>> getMessages(String chatId);
}