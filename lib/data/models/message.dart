import 'dart:io';

import 'package:floor/floor.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Message {
  final int? id;
  final String? message;
  final File? image;
  final String? createdAt;
  final String? chatId;
  final String? from;
  Message({
    this.id,
    this.message,
    this.createdAt,
    this.chatId,
    this.image,
    this.from,
  });
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      chatId: json['chatId'],
      createdAt: json['createdAt'],
      id: json['id'],
      message: json['message'],
      image: File(json['image']),
      from: json['from'],
    );
  }
  factory Message.fromContent(Content content) {
    String message = "";
    File? image;
    for (var e in content.parts) {
      if (e is TextPart) {
        message = e.text;
      }
      if (e is DataPart) {
        image = File.fromRawPath(e.bytes);
      }
    }
    return Message(
      message: message,
      image: image,
      from: "chatbot",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'createdAt': createdAt,
      'id': id,
      'message': message,
      'image': image?.path,
      'from': from,
    };
  }

  Content toContent() {
    if (image != null) {
      final img = image!.readAsBytesSync();
      final imgPart = DataPart('image/jpeg', img);
      return Content.multi([imgPart, TextPart(message ?? "")]);
    }
    return Content.text(message ?? "");
  }
}

@Entity(primaryKeys: ['id'], tableName: 'messages')
class MessageEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? message;
  final String? image;
  final String? createdAt;
  final String? chatId;
  MessageEntity({
    this.id,
    this.message,
    this.createdAt,
    this.chatId,
    this.image,
  });
  factory MessageEntity.fromJson(Map<String, dynamic> json) {
    return MessageEntity(
      chatId: json['chatId'],
      createdAt: json['createdAt'],
      id: json['id'],
      message: json['message'],
      image: json['image'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'createdAt': createdAt,
      'id': id,
      'message': message,
      'image': image,
    };
  }

  Message toMessage() {
    return Message(
      chatId: chatId,
      createdAt: createdAt,
      id: id,
      image: image != null ? File(image!) : null,
      message: message,
    );
  }
}
