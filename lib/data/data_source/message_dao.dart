import 'package:flutter_chatbot/data/models/message.dart';
import 'package:floor/floor.dart';

@dao
abstract class MessageDAO {
  @Query('SELECT * FROM messages')
  Stream<List<MessageEntity>> findAllMessages();

  @Query('SELECT * FROM messages WHERE chatId = :id')
  Stream<List<MessageEntity>> findMessageByChatId(int id);

  @insert
  Future<void> insertMessage(MessageEntity message);
}
