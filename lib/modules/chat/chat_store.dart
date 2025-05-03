// ignore_for_file: library_private_types_in_public_api

import 'package:fidooo_chat/modules/chat/models/chat.dart';
import 'package:fidooo_chat/modules/chat/models/message.dart';
import 'package:mobx/mobx.dart';

part 'chat_store.g.dart';
enum ChatStatus { init,waitingChats, waitingAddMessage , initiated}

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {

  @observable
  String? currentChat;

  @observable
  ChatStatus status = ChatStatus.init;

  @observable
  String newMessage = "";


  @observable
  ObservableList<Message> messages =ObservableList.of([]);

  @observable
  ObservableList<Chat> chats =ObservableList.of([]);


  @action
  setChats(List<Chat> chats){
    this.chats = ObservableList.of(chats);
  }

  @action
  setMessages(List<Message> messages){
    this.messages = ObservableList.of(messages);
  }

  @action
  clear(){
    messages = ObservableList.of([]);
    chats = ObservableList.of([]);
    currentChat = null;
    newMessage = "";
    status = ChatStatus.init;
  }
}