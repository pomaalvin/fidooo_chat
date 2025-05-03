import 'package:fidooo_chat/modules/chat/chat_controller.dart';
import 'package:fidooo_chat/modules/chat/chat_store.dart';
import 'package:fidooo_chat/shared/styles/color_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
class ChatInput extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final ChatStore chatStore;
  final ChatController chatController;

  const ChatInput({
    super.key,required this.focusNode,required this.controller,
    required this.chatStore,required this.chatController
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {

  @override
  void initState() {
    widget.focusNode.addListener((){
      setState(() {});
    });
    super.initState();
  }
  _addMessage() {
    widget.chatController.addMessage().then((value) {
      widget.controller.text = "";
      widget.focusNode.requestFocus();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Container(
          decoration: BoxDecoration(
            color: AppColorStyles.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1.5,color: widget.focusNode.hasFocus?AppColorStyles.primary:AppColorStyles.lightGrey50),
          ),
          padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                onChanged: (value) {
                  widget.chatStore.newMessage = value;
                },
                style: TextStyle(color: AppColorStyles.darkgrey),
                onSubmitted: (value) {
                  _addMessage();
                },
                readOnly: widget.chatStore.status == ChatStatus.waitingAddMessage,
                decoration: InputDecoration(
                  hintText: "Pregunta a Fidooo",
                  hintStyle: TextStyle(color: AppColorStyles.lightGrey75),
                  border: InputBorder.none,
                ),
              ),
              InkWell(
                onTap: () {
                  if (widget.chatStore.newMessage.isNotEmpty) {
                    _addMessage();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.chatStore.newMessage.isNotEmpty?AppColorStyles.primary: AppColorStyles.lightGrey50,
                  ),
                  width: 40,
                  height: 40,
                  child:
                  widget.chatStore.status == ChatStatus.waitingAddMessage
                      ? Padding(
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(
                      color: AppColorStyles.white,
                    ),
                  )
                      : Icon(Icons.arrow_upward, color: AppColorStyles.white),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
