import 'package:flutter_chatbot/common/widgets/app_layout.dart';
import 'package:flutter_chatbot/data/data_source/chat_remote_data_source.dart';
import 'package:flutter_chatbot/presentation/pages/home/widgets/home_chat_stream.dart';
import 'package:flutter_chatbot/presentation/pages/home/widgets/home_prompt_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatRemoteDataSource dataSource = ChatRemoteDataSource();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AppLayout(
      surfaceColor: colorScheme.primary,
      brightness: Brightness.light,
      child: Scaffold(
        backgroundColor: colorScheme.surfaceBright,
        appBar: AppBar(
          backgroundColor: colorScheme.primary,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.robot, color: colorScheme.onPrimary),
              const SizedBox(width: 12),
              const Text("AI Chatbot"),
            ],
          ),
          titleTextStyle: TextStyle(fontSize: 24, color: colorScheme.onPrimary),
          centerTitle: true,
        ),
        body: Column(
          children: [
            HomeChatStream(
              dataSource: dataSource,
              scrollController: scrollController,
            ),
            HomePromptInput(
              onSendPrompt: () async {
                if (scrollController.hasClients) {
                  await scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              dataSource: dataSource,
            ),
          ],
        ),
      ),
    );
  }
}
