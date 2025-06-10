abstract class ConversationsRepo {
  void sendMessage(String to , String message);
  Stream<List<dynamic>> getMessagesOfConversation(String instructorId);
  Stream<List<dynamic>> getAllConversations();
}