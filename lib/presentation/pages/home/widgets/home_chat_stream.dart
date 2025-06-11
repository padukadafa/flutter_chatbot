import 'package:flutter_chatbot/data/data_source/chat_remote_data_source.dart';
import 'package:flutter_chatbot/data/models/message.dart';
import 'package:flutter_chatbot/presentation/pages/home/widgets/home_message_loading.dart';
import 'package:flutter_chatbot/presentation/pages/home/widgets/home_message_prompt.dart';
import 'package:flutter_chatbot/presentation/pages/home/widgets/home_prompt_result.dart';
import 'package:flutter_chatbot/presentation/pages/welcome/welcome_page.dart';
import 'package:flutter/material.dart';

class HomeChatStream extends StatelessWidget {
  final ChatRemoteDataSource dataSource;
  final ScrollController scrollController;
  const HomeChatStream({
    super.key,
    required this.dataSource,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<Message>>(
        stream: dataSource.getMessage(),
        builder: (context, snapshot) {
          if (snapshot.data?.isEmpty ?? true) {
            return const WelcomePage();
          }
          return ListView.builder(
            controller: scrollController,
            itemCount: snapshot.data?.length ?? 3,
            itemBuilder: (context, index) {
              if (!snapshot.hasData) {
                return const MessageLoading();
              }
              if (snapshot.data?[index].from == "sender") {
                return MessagePrompt(prompt: snapshot.data?[index].message);
              }
              if (snapshot.data?[index].message == null) {
                return const MessageLoading();
              }
              return PromptResult(promptResult: snapshot.data?[index].message);
            },
          );
        },
      ),
    );
  }
}
