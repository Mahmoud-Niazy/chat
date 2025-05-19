import 'package:chat/core/failure/failure.dart';
import 'package:chat/features/blocked_users/data/models/blocked_user_model/blocked_user_model.dart';
import 'package:chat/features/blocked_users/domain/usecases/get_blocked_users_use_case.dart';
import 'package:chat/features/blocked_users/domain/usecases/unblock_user_use_case.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocked_users_states.dart';

class BlockedUsersCubit extends Cubit<BlockedUsersStates> {
  final GetBlockedUsersUseCase getBlockedUsersUseCase;
  final UnblockUserUseCase unblockUserUseCase;

  BlockedUsersCubit(this.getBlockedUsersUseCase,
      this.unblockUserUseCase) : super(BlockedUsersInitialState());

  List<BlockedUserModel> blockedUsers = [];

  Future<void> getBlockedUsers() async {
    emit(GetBlockedUsersSuccessState());
    try{
      blockedUsers = await getBlockedUsersUseCase.execute();
      emit(GetBlockedUsersSuccessState());
    }
    catch(error){
      if(error is DioException){
        emit(BlockedUsersErrorState(ServerFailure.fromDioException(error).error));
      }
      else{
        emit(BlockedUsersErrorState(error.toString()));
      }
    }
  }

  Future<void> unblockUser(String userId)async{
    emit(UnblockUserLoadingState());
    try{
      await unblockUserUseCase.execute(userId);
      emit(UnblockUserSuccessState());
    }
    catch(error){
      if(error is DioException){
        emit(BlockedUsersErrorState(ServerFailure.fromDioException(error).error));
      }
      else{
        emit(BlockedUsersErrorState(error.toString()));
      }
    }
  }
}