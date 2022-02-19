part of 'login_page_ui_bloc.dart';

@immutable
abstract class LoginPageUiState {}

class LoginPageUiInitial extends LoginPageUiState {}

class ChangingMobileNumberState extends LoginPageUiState {}

class MobileNumberChangedState extends LoginPageUiState {
  String username;
  MobileNumberChangedState({this.username = ""});

  @override
  List<Object> get props => [username];
}

class LoginPageErrorState extends LoginPageUiState {
  String errMsg;
  LoginPageErrorState({this.errMsg = ""});

  @override
  List<Object> get props => [errMsg];
}

class ChangingPasswordState extends LoginPageUiState {}

class PasswordChangedState extends LoginPageUiState {
  String password;
  PasswordChangedState({required this.password});

  @override
  List<Object> get props => [password];
}

class AuthenticatingUserCredentialsState extends LoginPageUiState {
  String username;
  String password;
  AuthenticatingUserCredentialsState(
      {required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class UserAuthenticatedSuccefullyState extends LoginPageUiState {
  UserInfoMockData? userInfo;
  UserAuthenticatedSuccefullyState({required this.userInfo});

  @override
  List<Object> get props => userInfo == null ? [] : [userInfo!];
}
