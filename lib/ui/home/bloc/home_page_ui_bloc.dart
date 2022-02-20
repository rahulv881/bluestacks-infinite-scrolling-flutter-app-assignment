import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/constants.dart';
import 'package:flutter_assignment/model/user_info_mock_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_page_ui_event.dart';
part 'home_page_ui_state.dart';

class HomePageUiBloc extends Bloc<HomePageUiEvent, HomePageUiState> {
  HomePageUiBloc() : super(HomePageUiInitial()) {
    on<LoadUserInfoEvent>((event, emit) async {
      try {
        emit(LoadingUserInfoState());
        WidgetsFlutterBinding.ensureInitialized();
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        if (prefs.containsKey(Constants.USER_INFO)) {
          UserInfoMockData userInfo =
              userInfoMockDataFromJson(prefs.getString(Constants.USER_INFO)!);
          emit(UserInfoLoadedState(userInfo: userInfo));
        } else {
          emit(ErrorLoadingUserInfoState(errMsg: 'No user info found'));
        }
      } catch (e) {
        emit(ErrorLoadingUserInfoState(errMsg: e.toString()));
      }
    });
  }
}
