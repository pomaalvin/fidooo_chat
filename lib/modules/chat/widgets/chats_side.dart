import 'package:fidooo_chat/modules/auth/auth_controller.dart';
import 'package:fidooo_chat/modules/chat/chat_controller.dart';
import 'package:fidooo_chat/modules/chat/chat_store.dart';
import 'package:fidooo_chat/modules/chat/models/chat.dart';
import 'package:fidooo_chat/shared/styles/color_styles.dart';
import 'package:fidooo_chat/shared/styles/text_styles.dart';
import 'package:fidooo_chat/shared/utils/date_time_formatter.dart';
import 'package:fidooo_chat/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChatsSide extends StatelessWidget {
  final ChatStore chatStore;
  final ChatController chatController;
  final AuthController authController = Modular.get<AuthController>();
  ChatsSide({
    super.key,
    required this.chatStore,
    required this.chatController,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: Border(right: BorderSide(color: AppColorStyles.lightGrey50)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                AppButton(
                  onTap: () {
                    Modular.to.navigate("/chats/new");
                    Scaffold.of(context).closeDrawer();
                  },
                  text: "Nuevo Chat +",
                  size: ButtonSize.small,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Chats",
              style: AppTextStyles.body.copyWith(
                color: AppColorStyles.lightGrey,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Divider(color: AppColorStyles.lightGrey50,thickness: 1,height: 1,),
          Expanded(
            child: Observer(
              builder: (_) {
                if (chatStore.status == ChatStatus.waitingChats) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: chatStore.chats.length,
                  itemBuilder: (context, index) {
                    Chat chat = chatStore.chats[index];
                    return InkWell(
                      onTap: () {
                        Modular.to.navigate("/chats/${chat.id}");
                        Scaffold.of(context).closeDrawer();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              chat.title +
                                  (chat.title.length >= 30 ? "..." : ""),
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.body.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              chat.createdAt.formatDate(date: true),
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.label.copyWith(
                                color: AppColorStyles.lightGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColorStyles.lightGrey35,
              border: Border(
                top: BorderSide(color: AppColorStyles.lightGrey50),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: InkWell(
              onTap: () {
                authController.logout();
              },
              child: Text(
                "Cerrar Sesión",
                style: TextStyle(color: AppColorStyles.primary),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
