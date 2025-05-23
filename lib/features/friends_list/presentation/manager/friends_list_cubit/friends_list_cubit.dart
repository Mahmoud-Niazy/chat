import 'package:chat/features/friends_list/data/models/friend_model/friend_model.dart';
import 'package:chat/features/friends_list/domain/usecases/block_friend_use_case.dart';
import 'package:chat/features/friends_list/domain/usecases/delete_friend_use_cas.dart';
import 'package:chat/features/friends_list/domain/usecases/get_all_friends_use_case.dart';
import 'package:chat/features/friends_list/presentation/manager/friends_list_cubit/friends_list_states.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/failure/failure.dart';

class FriendsListCubit extends Cubit<FriendsListStates> {
  final GetAllFriendsUseCase getAllFriendsUseCase;
  final DeleteFriendUseCase deleteFriendUseCase;
  final BlockFriendUseCase blockFriendUseCase;

  FriendsListCubit(
    this.getAllFriendsUseCase,
    this.deleteFriendUseCase,
    this.blockFriendUseCase,
  ) : super(FriendsListInitialState());

  List<FriendModel> allFriends = [];

  Future<void> getAllFriends() async {
    emit(GetFriendsListLoadingState());
    try {
      allFriends = await getAllFriendsUseCase.execute();
      emit(GetFriendsListSuccessfullyState());
    } catch (error) {
      if (error is DioException) {
        emit(
          FriendsListErrorState(ServerFailure.fromDioException(error).error),
        );
      } else {
        emit(FriendsListErrorState(error.toString()));
      }
    }
  }

  Future<void> deleteFriend(String userId) async {
    emit(DeleteFriendLoadingState());
    try {
      await deleteFriendUseCase.execute(userId);
      await getAllFriends();
      emit(DeleteFriendSuccessfullyState());
    } catch (error) {
      if (error is DioException) {
        emit(
          FriendsListErrorState(ServerFailure.fromDioException(error).error),
        );
      } else {
        emit(FriendsListErrorState(error.toString()));
      }
    }
  }

  Future<void> blockFriend(String userId) async {
    emit(BlockFriendLoadingState());
    try {
      await blockFriendUseCase.execute(userId);
      await getAllFriends();
      emit(BlockFriendSuccessfullyState());
    } catch (error) {
      if (error is DioException) {
        emit(
          FriendsListErrorState(ServerFailure.fromDioException(error).error),
        );
      } else {
        emit(FriendsListErrorState(error.toString()));
      }
    }
  }
}
