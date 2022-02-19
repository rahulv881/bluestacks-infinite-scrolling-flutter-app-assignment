part of 'login_page_ui_bloc.dart';

@immutable
abstract class LoginPageUiEvent {}

class ChangeMobileNumberEvent extends LoginPageUiEvent {
  String username;
  ChangeMobileNumberEvent({required this.username});

  @override
  List<Object> get props => [username];
}

class ChangePasswordEvent extends LoginPageUiEvent {
  String password;
  ChangePasswordEvent({required this.password});

  @override
  List<Object> get props => [password];
}

class LoginUserEvent extends LoginPageUiEvent {
  String username;
  String password;
  LoginUserEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}
