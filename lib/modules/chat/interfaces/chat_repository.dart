import 'package:fidooo_chat/modules/chat/dto/new_message_dto.dart';

abstract class ChatRepository{

  Future<void> newMessage(NewMessageDto newMessageDto);
}