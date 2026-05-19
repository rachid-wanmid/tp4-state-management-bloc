part of 'chat_bloc.dart';

class ChatMessage {
  final String role;
  final String content;

  ChatMessage({required this.role, required this.content});
}

class ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? error;

  ChatState({
    required this.messages,
    this.isLoading = false,
    this.error,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error, // Can be null to clear error
    );
  }
}
