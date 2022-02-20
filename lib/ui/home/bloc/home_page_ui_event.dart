part of 'home_page_ui_bloc.dart';

@immutable
abstract class HomePageUiEvent {}

class LoadUserInfoEvent extends HomePageUiEvent {}

class LoadNextTenTournamentsEvent extends HomePageUiEvent {
  String cursor;
  LoadNextTenTournamentsEvent({required this.cursor});

  @override
  List<Object> get props => [cursor];
}
