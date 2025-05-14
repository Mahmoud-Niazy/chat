import 'package:chat/core/failure/failure.dart';
import 'package:chat/features/profile/domain/usecases/get_user_data_use_case.dart';
import 'package:chat/features/profile/presentation/manager/profile_cubit/profile_states.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user_model/user_model.dart';

class ProfileCubit extends Cubit<ProfileStates>{
  final GetUserDataUseCase getUserDataUseCase;

  ProfileCubit(this.getUserDataUseCase) : super(ProfileInitialState());

  late UserModel userData ;
  Future<void> getUserData()async{
    emit(GetUserDataLoadingState());
    try{
      userData = await getUserDataUseCase.execute();
      emit(GetUserDataSuccessfullyState());
    }
    catch(error){
      if(error is DioException){
        emit(GetUserDataErrorState(ServerFailure.fromDioException(error).error));
      }
      else{
        emit(GetUserDataErrorState(error.toString()));
      }
    }
  }


}