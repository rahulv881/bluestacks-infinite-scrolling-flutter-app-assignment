part of 'home_page_ui_bloc.dart';

@immutable
abstract class HomePageUiState {}

class HomePageUiInitial extends HomePageUiState {}

class LoadingUserInfoState extends HomePageUiState {}

class UserInfoLoadedState extends HomePageUiState {
  UserInfoMockData userInfo;
  UserInfoLoadedState({required this.userInfo});

  @override
  List<Object> get props => [userInfo];
}

class ErrorLoadingUserInfoState extends HomePageUiState {
  String errMsg;
  ErrorLoadingUserInfoState({required this.errMsg});

  @override
  List<Object> get props => [errMsg];
}
