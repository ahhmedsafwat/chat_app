part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatSuccess extends ChatState {
  ChatSuccess({required this.messagesList});
  List<Message> messagesList = [];
}
