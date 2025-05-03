// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatStore on _ChatStore, Store {
  late final _$currentChatAtom =
      Atom(name: '_ChatStore.currentChat', context: context);

  @override
  String? get currentChat {
    _$currentChatAtom.reportRead();
    return super.currentChat;
  }

  @override
  set currentChat(String? value) {
    _$currentChatAtom.reportWrite(value, super.currentChat, () {
      super.currentChat = value;
    });
  }

  late final _$statusAtom = Atom(name: '_ChatStore.status', context: context);

  @override
  ChatStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(ChatStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$newMessageAtom =
      Atom(name: '_ChatStore.newMessage', context: context);

  @override
  String get newMessage {
    _$newMessageAtom.reportRead();
    return super.newMessage;
  }

  @override
  set newMessage(String value) {
    _$newMessageAtom.reportWrite(value, super.newMessage, () {
      super.newMessage = value;
    });
  }

  late final _$messagesAtom =
      Atom(name: '_ChatStore.messages', context: context);

  @override
  ObservableList<Message> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(ObservableList<Message> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  late final _$chatsAtom = Atom(name: '_ChatStore.chats', context: context);

  @override
  ObservableList<Chat> get chats {
    _$chatsAtom.reportRead();
    return super.chats;
  }

  @override
  set chats(ObservableList<Chat> value) {
    _$chatsAtom.reportWrite(value, super.chats, () {
      super.chats = value;
    });
  }

  late final _$_ChatStoreActionController =
      ActionController(name: '_ChatStore', context: context);

  @override
  dynamic setChats(List<Chat> chats) {
    final _$actionInfo =
        _$_ChatStoreActionController.startAction(name: '_ChatStore.setChats');
    try {
      return super.setChats(chats);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMessages(List<Message> messages) {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.setMessages');
    try {
      return super.setMessages(messages);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clear() {
    final _$actionInfo =
        _$_ChatStoreActionController.startAction(name: '_ChatStore.clear');
    try {
      return super.clear();
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentChat: ${currentChat},
status: ${status},
newMessage: ${newMessage},
messages: ${messages},
chats: ${chats}
    ''';
  }
}
