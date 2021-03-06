import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/constants.dart';
import 'package:flutter_assignment/model/Response.dart';
import 'package:flutter_assignment/model/user_info_mock_data.dart';

import 'package:flutter_assignment/ui/login/login_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_page_ui_event.dart';
part 'login_page_ui_state.dart';

class LoginPageUiBloc extends Bloc<LoginPageUiEvent, LoginPageUiState> {
  final LoginRepo _repo = LoginRepo();
  LoginPageUiBloc() : super(LoginPageUiInitial()) {
    on<ChangeMobileNumberEvent>((event, emit) {
      try {
        emit(ChangingMobileNumberState());
        String username = event.username;
        emit(MobileNumberChangedState(username: username));
      } catch (e) {
        emit(LoginPageErrorState(errMsg: e.toString()));
      }
    });
    on<ChangePasswordEvent>((event, emit) async {
      try {
        emit(ChangingPasswordState());
        String password = event.password;
        emit(PasswordChangedState(password: password));
      } catch (e) {
        emit(LoginPageErrorState(errMsg: e.toString()));
      }
    });
    on<LoginUserEvent>((event, emit) async {
      try {
        String username = event.username;
        String password = event.password;
        int usernameLength = username.length;
        int passwordLength = password.length;

        if (usernameLength == 0) {
          emit(LoginPageErrorState(errMsg: "Please enter mobile number"));
        } else if (passwordLength == 0) {
          emit(LoginPageErrorState(errMsg: "Please enter password"));
        } else if (usernameLength < 3) {
          emit(LoginPageErrorState(
              errMsg: "Mobile number should be at least 3 characters long"));
        } else if (usernameLength > 11) {
          emit(LoginPageErrorState(
              errMsg: "Mobile number should be at max 11 characters long"));
        } else if (passwordLength < 3) {
          emit(LoginPageErrorState(
              errMsg: "Password should be aleast 3 characters long"));
        } else if (passwordLength > 11) {
          emit(LoginPageErrorState(
              errMsg: "Password should be at max 11 characters long"));
        } else {
          emit(AuthenticatingUserCredentialsState(
              username: username, password: password));
          CustomResponseWrapper<String, UserInfoMockData> response = await _repo
              .authenticateUser(username: username, password: password);
          String errMsg = response.errMsg;
          UserInfoMockData? userInfo = response.res;
          if (errMsg.isNotEmpty) {
            emit(LoginPageErrorState(errMsg: errMsg));
          } else {
            WidgetsFlutterBinding.ensureInitialized();
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            prefs.setBool(Constants.IS_LOGGED_IN, true);
            prefs.setString(
                Constants.USER_INFO, userInfoMockDataToJson(userInfo!));
            emit(UserAuthenticatedSuccefullyState(userInfo: userInfo));
          }
        }
      } catch (e) {
        emit(LoginPageErrorState(errMsg: e.toString()));
      }
    });
  }
}
