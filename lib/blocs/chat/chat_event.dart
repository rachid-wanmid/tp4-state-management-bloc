part of 'chat_bloc.dart';

abstract class ChatEvent {}

class ChatMessageSent extends ChatEvent {
  final String message;

  ChatMessageSent({required this.message});
}
