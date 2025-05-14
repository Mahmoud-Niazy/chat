import 'package:chat/core/failure/failure.dart';
import 'package:chat/features/add_friend/domain/usecases/send_friend_request_use_case.dart';
import 'package:chat/features/add_friend/presentation/manager/add_friend_cubit/add_friend_states.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFriendRequestCubit extends Cubit<AddFriendStates>{
  final SendFriendRequestUseCase sendFriendRequestUseCase;
  AddFriendRequestCubit(this.sendFriendRequestUseCase) : super(AddFriendInitialState());

  Future<void> sendFriendRequest(String userId)async{
    emit(SendFriendRequestLoadingState());
    try{
      await sendFriendRequestUseCase.execute(userId);
    }
    catch(error){
      if(error is DioException){
        emit(SendFriendRequestErrorState(ServerFailure.fromDioException(error).error));
      }
    else{
        emit(SendFriendRequestErrorState(error.toString()));
      }
    }
  }
}