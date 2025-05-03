// ignore_for_file: unused_import

import 'package:fidooo_chat/modules/chat/chat_controller.dart';
import 'package:fidooo_chat/modules/chat/chat_store.dart';
import 'package:fidooo_chat/modules/chat/widgets/chat_input.dart';
import 'package:fidooo_chat/modules/chat/widgets/chats_side.dart';
import 'package:fidooo_chat/modules/chat/widgets/messages_layout.dart';
import 'package:fidooo_chat/shared/styles/color_styles.dart';
import 'package:fidooo_chat/shared/styles/text_styles.dart';
import 'package:fidooo_chat/shared/widgets/app_input.dart';
import 'package:fidooo_chat/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChatPage extends StatefulWidget {
  final String? chatId;

  const ChatPage({super.key, required this.chatId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final chatStore = Modular.get<ChatStore>();
  final chatController = Modular.get<ChatController>();

  final TextEditingController messageController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    chatController.init(chatId: widget.chatId);
    focusNode.requestFocus();
    focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  Widget _welcome() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Hola, ¿Cómo te puedo ayudar?',
          style: AppTextStyles.title.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColorStyles.grey,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ru = ResponsiveUtils(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (ru.gtSm())
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'FIDOOO CHAT',
              style: AppTextStyles.subtitle.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColorStyles.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        Observer(
            builder: (_) {
            return Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 800),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    chatStore.currentChat == null
                        ? _welcome()
                        : Expanded(child: MessagesLayout(chatStore: chatStore)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ChatInput(
                        focusNode: focusNode,
                        controller: messageController,
                        chatStore: chatStore,
                        chatController: chatController,
                      ),
                    ),
                    SizedBox(height: ru.gtSm() ? 24 : 8),
                  ],
                ),
              ),
            );
          }
        ),
      ],
    );
  }
}
