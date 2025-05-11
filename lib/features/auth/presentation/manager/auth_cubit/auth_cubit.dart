import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/cache_helper/cache_helper.dart';
import '../../../../../core/failure/failure.dart';
import '../../../../../core/utils/app_keys.dart';
import '../../../data/models/user_registration_response_model.dart';
import '../../../domain/use_cases/reset_password_use_case.dart';
import '../../../domain/use_cases/send_reset_password_code_use_case.dart';
import '../../../domain/use_cases/sign_in_use_case.dart';
import '../../../domain/use_cases/sign_up_use_case.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SendResetPasswordCodeUseCase sendResetPasswordCodeUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  AuthCubit(
    this.signInUseCase,
    this.signUpUseCase,
      this.sendResetPasswordCodeUseCase,
      this.resetPasswordUseCase,
  ) : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(SignInLoadingState());
    try {
      UserRegistrationResponseDataModel userRegistrationResponseDataModel =
          await signInUseCase.execute(
        email: email,
        password: password,
      );
      await CacheHelper.saveData(
          key: AppKeys.token,
          value: userRegistrationResponseDataModel.accessToken);
      await CacheHelper.saveData(
          key: AppKeys.userId,
          value: userRegistrationResponseDataModel.userId);
      emit(SignInSuccessfullyState());
    } catch (error) {
      if (error is DioException) {
        emit(SignInErrorState(ServerFailure.fromDioException(error).error));
      } else {
        emit(SignInErrorState(error.toString()));
      }
    }
  }

  Future<void> signUp({
    required String email,
    required String name,
    required String password,
    required String phone,
  }) async {
    emit(SignUpLoadingState());
    try{
      UserRegistrationResponseDataModel userRegistrationResponseDataModel =
      await signUpUseCase.execute(
        email: email,
        name: name,
        phone: phone,
        password: password,
      );
      await CacheHelper.saveData(
          key: AppKeys.token,
          value: userRegistrationResponseDataModel.accessToken);
      await CacheHelper.saveData(
          key: AppKeys.userId,
          value: userRegistrationResponseDataModel.userId);
      emit(SignUpSuccessfullyState());
    }
    catch(error){
      if (error is DioException) {
        emit(SignInErrorState(ServerFailure.fromDioException(error).error));
      } else {
        emit(SignInErrorState(error.toString()));
      }
    }
  }

  Future<void> sendPasswordResetCode(String email)async{
    emit(SendPasswordResetCodeLoadingState());
    try{
      await sendResetPasswordCodeUseCase.execute(email);
      emit(SendPasswordResetCodeSuccessfullyState(email));
    }
    catch(error){
      if (error is DioException) {
        emit(SendPasswordResetCodeErrorState(ServerFailure.fromDioException(error).error));
      } else {
        emit(SendPasswordResetCodeErrorState(error.toString()));
      }
    }
  }

  Future<void> resetPassword({
    required num code,
    required String newPassword,
    required String email,
  })async{
    emit(ResetPasswordLoadingState());
    try{
      await resetPasswordUseCase.execute(code: code, newPassword: newPassword, email: email);
      emit(ResetPasswordSuccessfullyState());
    }
        catch(error){
          if (error is DioException) {
            emit(ResetPasswordErrorState(ServerFailure.fromDioException(error).error));
          } else {
            emit(ResetPasswordErrorState(error.toString()));
          }
        }
  }
}
