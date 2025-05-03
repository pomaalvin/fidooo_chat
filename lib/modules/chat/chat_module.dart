import 'package:fidooo_chat/modules/chat/chat_controller.dart';
import 'package:fidooo_chat/modules/chat/chat_page.dart';
import 'package:fidooo_chat/modules/chat/chat_store.dart';
import 'package:fidooo_chat/modules/chat/interfaces/chat_repository.dart';
import 'package:fidooo_chat/modules/chat/interfaces/chat_stream_repository.dart';
import 'package:fidooo_chat/modules/chat/repositories/firebase_chat_stream_repository.dart';
import 'package:fidooo_chat/modules/chat/repositories/http_chat_repository.dart';
import 'package:fidooo_chat/modules/chat/widgets/chats_side.dart';
import 'package:fidooo_chat/shared/styles/color_styles.dart';
import 'package:fidooo_chat/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChatModule extends Module{
  @override
  void binds(Injector i) {
    i.add<ChatStreamRepository>(FirebaseChatStreamRepository.new);
    i.add<ChatRepository>(HttpChatRepository.new);
    i.addSingleton(ChatStore.new);
    i.addSingleton<ChatController>(() => ChatController(i.get<ChatStore>(), i.get<ChatStreamRepository>(), i.get<ChatRepository>()),config: BindConfig(onDispose: (val){val.dispose();}));
    super.binds(i);
  }
  @override
  void routes(RouteManager r) {
    r.redirect("/", to: "/chats/new");
    r.child("/",child: (context) => ChatMain(),transition: TransitionType.noTransition,
    children: [
      ChildRoute("/new", child:  (context) => ChatPage(chatId: null)),
      ChildRoute("/:id", child:  (context) => ChatPage(chatId: r.args.params["id"]))
    ]);
    super.routes(r);
  }
}

class ChatMain extends StatelessWidget {

  ChatMain({super.key});

  final chatStore = Modular.get<ChatStore>();

  final chatController = Modular.get<ChatController>();

  @override
  Widget build(BuildContext context) {
    final ru = ResponsiveUtils(context);
    return Scaffold(
        appBar: ru.lwSm()?AppBar(
      backgroundColor: AppColorStyles.lightGrey35,
          surfaceTintColor: AppColorStyles.lightGrey35,
        ):null,
    drawer: ru.lwSm()?ChatsSide(chatStore: chatStore,chatController: chatController,):null,
      body: Stack(
        children: [
          Positioned.fill(
            child: Row(
              children: [
                if(ru.gtSm())
                ChatsSide(chatStore: chatStore,chatController: chatController,),
                Expanded(child: RouterOutlet()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
