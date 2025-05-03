class NewMessageDto{
  String text;
  String? chatId;
  NewMessageDto({
    required this.text,
    required this.chatId
});
  toJson()=>{
    "text": text,
    if(chatId!=null)"chatId": chatId
  };
}