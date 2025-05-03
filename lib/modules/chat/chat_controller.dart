
import 'dart:async';
import 'dart:developer';

import 'package:fidooo_chat/modules/chat/chat_store.dart';
import 'package:fidooo_chat/modules/chat/dto/new_message_dto.dart';
import 'package:fidooo_chat/modules/chat/interfaces/chat_repository.dart';
import 'package:fidooo_chat/modules/chat/interfaces/chat_stream_repository.dart';
import 'package:fidooo_chat/shared/services/alert_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChatController{
  final ChatStore store;
  final ChatStreamRepository chatStreamRepository;
  final ChatRepository chatRepository;
  final AlertService alertService = Modular.get<AlertService>();
  ChatController(this.store,this.chatStreamRepository, this.chatRepository);

  StreamSubscription? chatsSubscription;
  StreamSubscription? messagesSubscription;

  init({String? chatId})async {
    store.clear();
    store.status = ChatStatus.waitingChats;
    chatsSubscription?.cancel();
    chatsSubscription = chatStreamRepository.getChats().listen((event) {
      if(event.isNotEmpty && store.currentChat==null && store.status==ChatStatus.waitingAddMessage){
        Modular.to.navigate("/chats/${event.last.id}");
      }
      store.status = ChatStatus.initiated;
      store.setChats(event.reversed.toList());
    });
    if(chatId?.isNotEmpty==true){
      selectCurrentChat(chatId!);
    }
  }

  selectCurrentChat(String chatId) async{

    store.setMessages([]);
    store.currentChat = chatId;
    messagesSubscription?.cancel();
    messagesSubscription = chatStreamRepository.getMessages(chatId).listen((event) {
      store.setMessages(event);
    });
  }

  dispose(){
    store.clear();
    chatsSubscription?.cancel();
    messagesSubscription?.cancel();
  }


  Future<void> addMessage()async {
    try{
      store.status = ChatStatus.waitingAddMessage;
      NewMessageDto newMessageDto = NewMessageDto(text: store.newMessage, chatId: store.currentChat);
      await chatRepository.newMessage(newMessageDto);
      store.status = ChatStatus.initiated;
      store.newMessage = "";

    }catch(e){
      store.status = ChatStatus.initiated;
      log(e.toString());
      alertService.showError("Ocurrio un error");
    }
  }
}