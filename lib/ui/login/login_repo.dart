import 'package:flutter_assignment/model/Response.dart';
import 'package:flutter_assignment/model/user_info_mock_data.dart';

class LoginRepo {
  Future<CustomResponseWrapper<String, UserInfoMockData>> authenticateUser(
      {required String username, required String password}) async {
    // * Mocking auth api call.
    await Future.delayed(Duration(seconds: 1));
    final users = [
      UserInfoMockData(
        name: "Simon Baker",
        userId: 1,
        profileImgUrl: "",
        password: "password123",
        mobileNumber: "9898989898",
        rating: 2250,
      ),
      UserInfoMockData(
        name: "Simon Baker2",
        userId: 2,
        profileImgUrl: "",
        password: "password123",
        mobileNumber: "9876543210",
        rating: 2200,
      ),
    ];

    final isValidUser =
        users.any((user) => user.mobileNumber.compareTo(username) == 0);
    if (!isValidUser) {
      return CustomResponseWrapper<String, UserInfoMockData>(
          errMsg: "No such user found", res: null);
    }
    final usersInfo = users
        .where((user) =>
            user.mobileNumber.compareTo(username) == 0 &&
            user.password.compareTo(password) == 0)
        .toList();

    if (usersInfo.length != 1) {
      return CustomResponseWrapper<String, UserInfoMockData>(
          errMsg: 'Please enter valid credentials.', res: null);
    }

    return CustomResponseWrapper<String, UserInfoMockData>(
        errMsg: "", res: usersInfo.first);
  }
}
