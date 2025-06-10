import 'dart:async';
import 'package:chat/core/scocket_io_services/socket_services.dart';
import 'package:chat/features/conversations/domain/repos/conversations_repo.dart';

class ConversationsRepoImp extends ConversationsRepo{
  final SocketService socket;
  ConversationsRepoImp(this.socket);
  
  @override
  Stream<List> getAllConversations() {
    final StreamController<List<dynamic>> conversationsStreamController = StreamController.broadcast();
    socket.emit('getConversations', null);
    socket.on('getConversations', (data){
      conversationsStreamController.add(data['conversations']);
    });
    return conversationsStreamController.stream;
  }

  @override
  Stream<List> getMessagesOfConversation(String instructorId) {
    // TODO: implement getMessagesOfConversation
    throw UnimplementedError();
  }

  @override
  void sendMessage(String to, String message) {
    // TODO: implement sendMessage
  }
  
}