import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_state/repositories/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;

  ChatBloc({required this.chatRepository}) : super(ChatState(messages: [])) {
    on<ChatMessageSent>(_onChatMessageSent);
  }

  Future<void> _onChatMessageSent(ChatMessageSent event, Emitter<ChatState> emit) async {
    // Add user message and set loading
    final userMessage = ChatMessage(role: 'user', content: event.message);
    final updatedMessages = List<ChatMessage>.from(state.messages)..add(userMessage);
    emit(state.copyWith(messages: updatedMessages, isLoading: true, error: null));

    try {
      // Send message via API
      final botResponse = await chatRepository.sendMessage(event.message);
      
      // Add bot message and stop loading
      final botMessage = ChatMessage(role: 'bot', content: botResponse);
      final finalMessages = List<ChatMessage>.from(state.messages)..add(botMessage);
      emit(state.copyWith(messages: finalMessages, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
