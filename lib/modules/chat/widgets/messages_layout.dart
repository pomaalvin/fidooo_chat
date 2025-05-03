import 'package:fidooo_chat/modules/chat/chat_store.dart';
import 'package:fidooo_chat/modules/chat/models/message.dart';
import 'package:fidooo_chat/shared/styles/color_styles.dart';
import 'package:fidooo_chat/shared/styles/text_styles.dart';
import 'package:fidooo_chat/shared/utils/date_time_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher.dart';

class MessagesLayout extends StatelessWidget {
  final ChatStore chatStore;
  const MessagesLayout({super.key, required this.chatStore});

  Future<void> _launchUrl(String url) async {
    await launchUrl(Uri.parse(url));
  }
  _cardMessage({
    required String text,
    required DateTime date,
    required bool bot,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bot ? AppColorStyles.white : AppColorStyles.lightGrey50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Markdown(
            data: text,
            
            shrinkWrap: true,
            onTapLink: (text, href, title) {
              if(href!=null){
                _launchUrl(href);
              }
            },
            selectable: true,
            padding: EdgeInsets.fromLTRB(10,10,10,0),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8,4,8,8),
            child: Text(date.formatDate(),style: AppTextStyles.label.copyWith(color: AppColorStyles.lightGrey),),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (chatStore.currentChat != null &&
            chatStore.messages.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false,),
          child: ListView.separated(
            itemCount: chatStore.messages.length,
            cacheExtent: 1000,
            reverse: true,
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
            itemBuilder: (context, index) {
              Message message = chatStore.messages[index];
              return FractionallySizedBox(
                widthFactor: 0.7,
                alignment:
                    message.bot ? Alignment.centerLeft : Alignment.centerRight,
                child: _cardMessage(
                  text: message.text,
                  date: message.createdAt,
                  bot: message.bot,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
