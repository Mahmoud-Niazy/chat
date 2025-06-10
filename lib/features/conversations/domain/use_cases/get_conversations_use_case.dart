import 'dart:async';
import 'package:chat/features/conversations/domain/repos/conversations_repo.dart';
import '../../data/models/conversation_model/conversation_model.dart';

class GetConversationsUseCase {
  final ConversationsRepo conversationsRepo;

  GetConversationsUseCase(this.conversationsRepo);

  Stream<List<ConversationModel>> execute() {
    final StreamController<List<ConversationModel>> conversationStreamController = StreamController.broadcast();
    List<ConversationModel> conversations = [];
    var res = conversationsRepo.getAllConversations();
    res.listen((data) {
      for(var conversation in data){
        conversations.add(ConversationModel.fromJson(conversation));
      }
      conversationStreamController.add(conversations);
    });
    return conversationStreamController.stream;
  }
}
