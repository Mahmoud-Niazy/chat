abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthErrorState extends AuthStates{
  final String error;
  AuthErrorState(this.error);
}

class SignInLoadingState extends AuthStates {}
class SignInSuccessfullyState extends AuthStates {}


class SignUpLoadingState extends AuthStates {}

class SignUpSuccessfullyState extends AuthStates {}

class SendPasswordResetCodeLoadingState extends AuthStates{}
class SendPasswordResetCodeSuccessfullyState extends AuthStates{
  final String email;
  SendPasswordResetCodeSuccessfullyState(this.email);
}

class ResetPasswordLoadingState extends AuthStates{}
class ResetPasswordSuccessfullyState extends AuthStates{}


