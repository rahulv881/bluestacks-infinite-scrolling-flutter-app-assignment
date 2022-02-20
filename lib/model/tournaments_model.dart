import 'dart:convert';

TournamentResponse tournamentResponseFromJson(String str) =>
    TournamentResponse.fromJson(json.decode(str));

String tournamentResponseToJson(TournamentResponse data) =>
    json.encode(data.toJson());

class TournamentResponse {
  TournamentResponse({
    required this.code,
    required this.data,
    required this.success,
  });

  int code;
  Data data;
  bool success;

  factory TournamentResponse.fromJson(Map<String, dynamic> json) =>
      TournamentResponse(
        code: json["code"],
        data: Data.fromJson(json["data"]),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
        "success": success,
      };
}

class Data {
  Data({
    required this.cursor,
    required this.tournamentCount,
    required this.tournaments,
    required this.isLastBatch,
  });

  String cursor;
  dynamic tournamentCount;
  List<Tournament> tournaments;
  bool isLastBatch;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cursor: json["cursor"],
        tournamentCount: json["tournament_count"],
        tournaments: List<Tournament>.from(
            json["tournaments"].map((x) => Tournament.fromJson(x))),
        isLastBatch: json["is_last_batch"],
      );

  Map<String, dynamic> toJson() => {
        "cursor": cursor,
        "tournament_count": tournamentCount,
        "tournaments": List<dynamic>.from(tournaments.map((x) => x.toJson())),
        "is_last_batch": isLastBatch,
      };
}

class Tournament {
  Tournament({
    required this.tournamentId,
    required this.name,
    required this.registrationUrl,
    required this.coverUrl,
    required this.gameName,
  });

  String tournamentId;
  String name;
  String registrationUrl;
  String coverUrl;
  String gameName;

  factory Tournament.fromJson(Map<String, dynamic> json) => Tournament(
        tournamentId: json["tournament_id"],
        name: json["name"],
        registrationUrl: json["registration_url"],
        coverUrl: json["cover_url"],
        gameName: json["game_name"],
      );

  Map<String, dynamic> toJson() => {
        "tournament_id": tournamentId,
        "name": name,
        "registration_url": registrationUrl,
        "cover_url": coverUrl,
        "game_name": gameName,
      };
}
