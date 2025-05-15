import 'package:chat/core/failure/failure.dart';
import 'package:chat/features/add_friend/data/models/search_result_model/search_result_model.dart';
import 'package:chat/features/add_friend/domain/usecases/find_user_use_case.dart';
import 'package:chat/features/add_friend/domain/usecases/send_friend_request_use_case.dart';
import 'package:chat/features/add_friend/presentation/manager/add_friend_cubit/add_friend_states.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFriendCubit extends Cubit<AddFriendStates> {
  final SendFriendRequestUseCase sendFriendRequestUseCase;
  final FindUserUseCase findUserUseCase;

  AddFriendCubit(this.sendFriendRequestUseCase, this.findUserUseCase)
    : super(AddFriendInitialState());

  void handleInitial(){
    user = null;
    emailController.text = '';
  }

  Future<void> sendFriendRequest(String userId,String email) async {
    emit(SendFriendRequestLoadingState());
    try {
      await sendFriendRequestUseCase.execute(userId);
      await findUser(email);
      emit(SendFriendRequestSuccessfullyState());
    } catch (error) {
      if (error is DioException) {
        emit(
          SendFriendRequestErrorState(
            ServerFailure.fromDioException(error).error,
          ),
        );
      } else {
        emit(SendFriendRequestErrorState(error.toString()));
      }
    }
  }


  SearchResultModel? user ;
  TextEditingController emailController = TextEditingController();
  Future<void> findUser(String email) async {
    emit(FindUserLoadingState());
    try {
      user = await findUserUseCase.execute(email);
      emit(FindUserSuccessfullyState());
    } catch (error) {
      if (error is DioException) {
        emit(
          FindUserErrorState(
            ServerFailure.fromDioException(error).error,
          ),
        );
      } else {
        emit(FindUserErrorState(error.toString()));
      }
    }
  }
}
