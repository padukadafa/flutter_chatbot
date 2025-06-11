import 'package:flutter_chatbot/data/data_source/chat_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class HomePromptInput extends StatefulWidget {
  final Future<void> Function() onSendPrompt;
  final ChatRemoteDataSource dataSource;
  const HomePromptInput({
    super.key,
    required this.onSendPrompt,
    required this.dataSource,
  });

  @override
  State<HomePromptInput> createState() => _HomePromptInputState();
}

class _HomePromptInputState extends State<HomePromptInput> {
  final messageFocus = FocusNode();

  final messageController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: messageController,
                focusNode: messageFocus,
                enabled: !loading,
                onTapOutside: (e) => messageFocus.unfocus(),
                onSubmitted: (value) => _sendPrompt(),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Ask something...",
                  contentPadding: EdgeInsets.only(left: 16, right: 6),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: _sendPrompt,
              icon: FaIcon(
                FontAwesomeIcons.paperPlane,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendPrompt() async {
    if (messageController.text.isEmpty) {
      return;
    }
    setState(() {
      loading = true;
    });
    await widget.dataSource.sendMessage(
      Content.text(messageController.text),
      afterSend: () async {
        setState(() {
          loading = false;
        });
        await widget.onSendPrompt();
      },
      beforeSend: () async {
        messageController.clear();
        await widget.onSendPrompt();
      },
    );
  }
}
