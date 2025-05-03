import 'package:fidooo_chat/modules/chat/dto/new_message_dto.dart';
import 'package:fidooo_chat/modules/chat/interfaces/chat_repository.dart';
// ignore: unused_import
import 'package:fidooo_chat/modules/chat/models/chat.dart';
import 'package:fidooo_chat/shared/utils/dio_client.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HttpChatRepository implements ChatRepository{

  final dioClient = Modular.get<DioClient>();
  @override
  Future<void> newMessage(NewMessageDto newMessageDto)async {
    await dioClient.dio.post("/messages",data: newMessageDto);
  }

}