abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class SignInLoadingState extends AuthStates {}

class SignInSuccessfullyState extends AuthStates {}

class SignInErrorState extends AuthStates {
  final String error;

  SignInErrorState(this.error);
}

class SignUpLoadingState extends AuthStates {}

class SignUpSuccessfullyState extends AuthStates {}

class SignUpErrorState extends AuthStates {
  final String error;

  SignUpErrorState(this.error);
}

class SendPasswordResetCodeLoadingState extends AuthStates{}
class SendPasswordResetCodeSuccessfullyState extends AuthStates{
  final String email;
  SendPasswordResetCodeSuccessfullyState(this.email);
}
class SendPasswordResetCodeErrorState extends AuthStates{
  final String error;
  SendPasswordResetCodeErrorState(this.error);
}

class ResetPasswordLoadingState extends AuthStates{}
class ResetPasswordSuccessfullyState extends AuthStates{}
class ResetPasswordErrorState extends AuthStates{
  final String error;
  ResetPasswordErrorState(this.error);
}

