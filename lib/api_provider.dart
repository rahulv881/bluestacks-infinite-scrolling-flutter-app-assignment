import 'dart:io';
import 'dart:convert';
import 'package:flutter_assignment/constants.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  static final ApiProvider _singleton = ApiProvider._();

  factory ApiProvider() {
    return _singleton;
  }
  Future<http.Response> getNextTenTournaments(String cursor) => http.get(
        Uri.parse('${Constants.TOURNAMENTS_BASE_URL}&cursor=$cursor'),
      );

  ApiProvider._();
}
