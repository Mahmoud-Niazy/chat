abstract class ConversationsStates {}

class ConversationsInitialState extends ConversationsStates{}

class SendMessageLoadingState extends ConversationsStates{}
class SendMessageSuccessState extends ConversationsStates{}
class SendMessageErrorState extends ConversationsStates{
  final String error;
  SendMessageErrorState(this.error);
}

class GetConversationsLoadingState extends ConversationsStates{}
class GetConversationsSuccessState extends ConversationsStates{}
class GetConversationsErrorState extends ConversationsStates{
  final String error;
  GetConversationsErrorState(this.error);
}

class GetMessagesLoadingState extends ConversationsStates{}
class GetMessagesSuccessState extends ConversationsStates{}
class GetMessagesErrorState extends ConversationsStates{
  final String error;
  GetMessagesErrorState(this.error);
}