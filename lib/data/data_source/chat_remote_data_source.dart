import 'package:flutter_chatbot/data/models/message.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatRemoteDataSource {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: dotenv.env['GEMINI_API_KEY'] ?? '',
  );
  ChatSession? chat;
  List<Message> messages = [];
  List<Message> tempMessages = [];
  Future<void> startChat() async {
    chat = model.startChat();
  }

  Stream<List<Message>> getMessage() async* {
    if (chat == null) {
      await startChat();
    }
    while (true) {
      await Future.delayed(const Duration(milliseconds: 200));
      yield messages;
    }
  }

  Future<void> sendMessage(
    Content content, {
    void Function()? beforeSend,
    void Function()? afterSend,
  }) async {
    if (chat == null) {
      await startChat();
    }

    messages.add(
      Message(message: (content.parts.first as TextPart).text, from: 'sender'),
    );
    messages.add(Message());
    await Future.delayed(const Duration(milliseconds: 200));
    if (beforeSend != null) {
      beforeSend();
    }

    final response = await chat!.sendMessage(content);
    messages.removeLast();
    messages.add(Message(message: response.text, from: 'chatbot'));

    await Future.delayed(const Duration(milliseconds: 200));

    if (afterSend != null) {
      afterSend();
    }
  }
}
