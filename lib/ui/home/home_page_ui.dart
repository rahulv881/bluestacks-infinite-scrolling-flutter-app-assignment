import 'package:flutter/material.dart';
import 'package:flutter_assignment/constants.dart';
import 'package:flutter_assignment/model/tournaments_model.dart';
import 'package:flutter_assignment/model/user_info_mock_data.dart';
import 'package:flutter_assignment/ui/home/bloc/home_page_ui_bloc.dart';
import 'package:flutter_assignment/widgets/recomended_for_you_card_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageUI extends StatefulWidget {
  static const TAG = "HOME PAGE UI";
  HomePageUI({Key? key}) : super(key: key);

  @override
  State<HomePageUI> createState() => _HomePageUIState();
}

class _HomePageUIState extends State<HomePageUI> {
  late HomePageUiBloc _homePageUiBloc;
  late HomePageUiBloc _homePageUiBloc2;
  late List<Tournament?> _tournaments;
  late ScrollController _scrollController;

  UserInfoMockData? _userInfoMockData;

  bool isLastBatch = false;
  String cursor = Constants.CURSOR;
  String errMsg = "";
  bool isLoadingNextTenTournaments = false;

  @override
  void initState() {
    _tournaments = [];
    _homePageUiBloc = HomePageUiBloc();
    _homePageUiBloc2 = HomePageUiBloc();
    _scrollController = ScrollController();

    _homePageUiBloc2.add(LoadNextTenTournamentsEvent(cursor: cursor));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !isLastBatch) {
        _homePageUiBloc2.add(LoadNextTenTournamentsEvent(cursor: cursor));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text("Flyingwolf", style: theme.textTheme.headline5),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: false,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildUserCardAndTournamentCard(theme),
              const SizedBox(height: 36.0),
              _buildRecommendedForYouList(theme),
            ],
          ),
        ),
      ),
    );
  }

  _buildUserCardAndTournamentCard(ThemeData theme) {
    return BlocProvider(
        create: (context) {
          if (_userInfoMockData == null) {
            _homePageUiBloc.add(LoadUserInfoEvent());
          }
          return _homePageUiBloc;
        },
        child: BlocConsumer<HomePageUiBloc, HomePageUiState>(
          key: const Key("User Card and Tournament Score Card"),
          buildWhen: (prev, current) {
            if (current is HomePageUiInitial) {
              return true;
            }
            if (current is UserInfoLoadedState) {
              return true;
            }
            if (current is ErrorLoadingUserInfoState) {
              return true;
            }
            if (current is LoadingUserInfoState) {
              return true;
            }
            return false;
          },
          listener: (context, state) {
            if (state is UserInfoLoadedState) {
              _userInfoMockData = state.userInfo;
            }
            if (state is ErrorLoadingUserInfoState) {
              SnackBarAction(
                  label: state.errMsg,
                  onPressed: () {
                    // TODO: hide snackbar on pressed
                  });
            }
          },
          builder: (context, state) {
            if (state is LoadingUserInfoState) {
              //: TODO show shimmer

            }
            if (state is UserInfoLoadedState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildUserCard(_userInfoMockData, theme),
                  const SizedBox(height: 36.0),
                  _buildTournamentCard(_userInfoMockData, theme),
                ],
              );
            }
            return Container();
          },
        ));
  }

  Row _buildUserCard(UserInfoMockData? _userInfoMockData, ThemeData theme) {
    return Row(
      key: const Key("User Card"),
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 2,
          child: CircleAvatar(
              backgroundImage:
                  NetworkImage((_userInfoMockData?.profileImgUrl) ?? ""),
              radius: 48.0),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (_userInfoMockData?.name) ?? "Nil",
                  style: theme.textTheme.headline4,
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.primaryColor, width: 1.5),
                    borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text:
                            ((_userInfoMockData?.rating.toString()) ?? "Nil") +
                                " ",
                        style: theme.textTheme.headline4!.copyWith(
                          color: theme.primaryColor,
                        ),
                        children: [
                          TextSpan(
                            text: 'Elo rating     ',
                            style: theme.textTheme.bodyText2!.copyWith(
                              color: const Color(0xFF647093),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildTournamentCard(UserInfoMockData? _userInfoMockData, ThemeData theme) {
    return Row(
      key: const Key("Tournament Score Card"),
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          key: const Key("Tournament Played"),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                bottomLeft: Radius.circular(24.0),
              ),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [0.1, 0.5, 0.7, 0.9],
                colors: [
                  Color(0xFFE47D01),
                  Color(0xFFE68A00),
                  Color(0xFFEA9A00),
                  Color(0xFFEAA104),
                ],
              ),
            ),
            child: Column(
              children: [
                Text(
                  (_userInfoMockData?.tournamentsPlayed.toString()) ?? "0",
                  style: theme.textTheme.subtitle1!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  "Tournament played",
                  style: theme.textTheme.bodyText1!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          key: const Key("Tournament Won"),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [0.1, 0.5, 0.7, 0.9],
                colors: [
                  Color(0xFF4E269A),
                  Color(0xFF6734A5),
                  Color(0xFF8746B2),
                  Color(0xFFA453BD),
                ],
              ),
            ),
            child: Column(
              children: [
                Text(
                  (_userInfoMockData?.tournamentsWon.toString()) ?? "0",
                  style: theme.textTheme.subtitle1!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  "Tournament won",
                  style: theme.textTheme.bodyText1!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          key: const Key("Winning percentage"),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24.0),
                bottomRight: Radius.circular(24.0),
              ),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [0.1, 0.5, 0.7, 0.9],
                colors: [
                  Color(0xFFEC5544),
                  Color(0xFFEC6148),
                  Color(0xFFEE764D),
                  Color(0xFFEE7E4E),
                ],
              ),
            ),
            child: Column(
              children: [
                Text(
                  ((_userInfoMockData?.winningPercentage.toString()) ?? "0") +
                      "%",
                  style: theme.textTheme.subtitle1!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  "Winning Percentage",
                  style: theme.textTheme.bodyText1!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildRecommendedForYouList(ThemeData theme) {
    return BlocProvider(
      create: (context) => _homePageUiBloc2,
      child: BlocConsumer<HomePageUiBloc, HomePageUiState>(
        listener: (context, state) {
          if (state is LoadingNextTenTournamentsState) {
            isLoadingNextTenTournaments = true;
            errMsg = "";
          }
          if (state is NextTenTournamentsLoadedState) {
            try {
              isLoadingNextTenTournaments = false;
              final tournamentResponse = state.tournamentResponse;
              List<Tournament> tournaments =
                  tournamentResponse.data.tournaments;
              // setState(() {
              cursor = tournamentResponse.data.cursor;
              isLastBatch = tournamentResponse.data.isLastBatch;
              errMsg = isLastBatch ? "Nothing more to show." : "";
              _tournaments.addAll(tournaments);
              // });
            } catch (e) {
              print(e);
            }
          }
          if (state is ErrorLoadingNextTenTournamentsState) {
            errMsg = state.errMsg;
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                key: const Key("Recommended for you"),
                itemBuilder: (BuildContext context, int index) {
                  return RecommendedForYouCardUI(
                      key: Key((_tournaments.elementAt(index)?.tournamentId) ??
                          index.toString()),
                      title: (_tournaments.elementAt(index)?.name) ?? "NA",
                      subtitle:
                          (_tournaments.elementAt(index)?.gameName) ?? "NA",
                      imgUrl: (_tournaments.elementAt(index)?.coverUrl) ?? "");
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 36.0),
                itemCount: _tournaments.length,
              ),
              if (isLoadingNextTenTournaments) const SizedBox(height: 36.0),
              if (isLoadingNextTenTournaments)
                const SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: CircularProgressIndicator(),
                ),
              if (isLoadingNextTenTournaments) const SizedBox(height: 36.0),
              if (errMsg.isNotEmpty) const SizedBox(height: 36.0),
              if (errMsg.isNotEmpty)
                SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: Text(
                    errMsg,
                    style:
                        theme.textTheme.bodyText1!.copyWith(color: Colors.red),
                  ),
                ),
              if (errMsg.isNotEmpty) const SizedBox(height: 36.0),
            ],
          );
        },
      ),
    );
  }
}
