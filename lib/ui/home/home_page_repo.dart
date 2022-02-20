import 'package:flutter_assignment/api_provider.dart';
import 'package:flutter_assignment/model/Response.dart';
import 'package:flutter_assignment/model/tournaments_model.dart';

class HomePageRepo {
  Future<CustomResponseWrapper<String, List<Tournament>>> getNextTenTournaments(
      {required String cursor}) async {
    ApiProvider _apiProvider = ApiProvider();
    final response = await _apiProvider.getNextTenTournaments(cursor);

    TournamentResponse tournamentResponse =
        tournamentResponseFromJson(response.body);
    List<Tournament> tournaments = [];
    String errMsg = "";
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      errMsg = "Something went wrong";
      tournamentResponse.data.tournaments;
    } else if (response.statusCode >= 300 && response.statusCode <= 399) {
      errMsg = "Something went wrong";
    } else if (response.statusCode >= 400 && response.statusCode <= 499) {
      errMsg = "Something went wrong";
    } else if (response.statusCode >= 500 && response.statusCode <= 599) {
      errMsg = "Something went wrong";
    }

    return CustomResponseWrapper<String, List<Tournament>>(
        errMsg: errMsg, res: tournaments);
  }
}
