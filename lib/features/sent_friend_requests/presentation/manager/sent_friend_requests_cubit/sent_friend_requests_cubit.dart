import 'package:chat/core/failure/failure.dart';
import 'package:chat/features/sent_friend_requests/data/models/sent_friend_request_model/sent_friend_request_model.dart';
import 'package:chat/features/sent_friend_requests/domain/usecases/get_sent_friend_requests_use_case.dart';
import 'package:chat/features/sent_friend_requests/domain/usecases/remove_sent_friend_request_use_case.dart';
import 'package:chat/features/sent_friend_requests/presentation/manager/sent_friend_requests_cubit/sent_friend_requests_states.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SentFriendRequestsCubit extends Cubit<SentFriendRequestsStates> {
  final GetSentFriendRequestsUseCase getSentFriendRequestsUseCase;
  final RemoveSentFriendRequestUseCase removeSentFriendRequestUseCase;

  SentFriendRequestsCubit(
    this.getSentFriendRequestsUseCase,
    this.removeSentFriendRequestUseCase,
  ) : super(SentFriendRequestsInitialState());

  List<SentFriendRequestModel> sentFriendRequests = [];

  Future<void> getSentFriendRequests() async {
    emit(GetSentFriendRequestsLoadingState());
    try {
      sentFriendRequests = await getSentFriendRequestsUseCase.execute();
      emit(GetSentFriendRequestsSuccessfullyState());
    } catch (error) {
      if (error is DioException) {
        emit(
          SentFriendRequestsErrorState(
            ServerFailure.fromDioException(error).error,
          ),
        );
      } else {
        emit(SentFriendRequestsErrorState(error.toString()));
      }
    }
  }

  Future<void> removeSentFriendRequest(String userId)async{
    emit(RemoveSentFriendRequestLoadingState());
    try{
      await removeSentFriendRequestUseCase.execute(userId);
      await getSentFriendRequests();
      emit(RemoveSentFriendRequestSuccessfullyState());
    }
    catch(error){
      if(error is DioException){
        emit(SentFriendRequestsErrorState(ServerFailure.fromDioException(error).error));
      }
      else{
        emit(SentFriendRequestsErrorState(error.toString()));
      }
    }

  }
}
