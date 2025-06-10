import 'package:chat/features/conversations/domain/use_cases/get_conversations_use_case.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/failure/failure.dart';
import '../../../data/models/conversation_model/conversation_model.dart';
import 'conversations_states.dart';

class ConversationsCubit extends Cubit<ConversationsStates>{
  final GetConversationsUseCase getConversationsUseCase;
  ConversationsCubit(this.getConversationsUseCase) : super(ConversationsInitialState());

  Stream<List<ConversationModel>>? conversationsStream ;
  List<ConversationModel> conversations = [];

  void getConversations(){
    emit(GetConversationsLoadingState());
    try {
      conversationsStream = getConversationsUseCase.execute();
      conversationsStream!.listen((data){
        conversations = [];
        for(var conversation in data) {
          conversations.add(conversation);
        }
        conversations.sort((a, b) {
          final dateA = DateTime.parse(a.createdAt);
          final dateB = DateTime.parse(b.createdAt);
          return dateB.compareTo(dateA); // Newest first
        });
        emit(GetConversationsSuccessState());
      });
    } catch (error) {
      if(error is DioException){
        emit(GetConversationsErrorState(ServerFailure.fromDioException(error).error));
      }
      else{
        emit(GetConversationsErrorState(error.toString()));
      }
    }
  }

}