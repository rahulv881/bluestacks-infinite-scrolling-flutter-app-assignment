import 'package:flutter/material.dart';
import 'package:flutter_assignment/constants.dart';
import 'package:flutter_assignment/ui/home/home_page_ui.dart';
import 'package:flutter_assignment/ui/login/login_page_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLoggedIn = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  isLoggedIn = prefs.getBool(Constants.IS_LOGGED_IN) ?? false;

  runApp(MyApp(initialRoute: isLoggedIn ? HomePageUI.TAG : LoginPage.TAG));
}

class MyApp extends StatelessWidget {
  String initialRoute;

  MyApp({Key? key, required this.initialRoute}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Assignment',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: const Color(0xFF446BFF),
          fontFamily: 'Roboto',
          scaffoldBackgroundColor: const Color(0xFFF9F9F9),
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.w600),
            headline2: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w600),
            headline3: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
            headline4: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600),
            headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
            headline6: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            subtitle1: TextStyle(fontSize: 20.0),
            subtitle2: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
            bodyText1: TextStyle(fontSize: 16.0),
            bodyText2: TextStyle(fontSize: 14.0),
          ).apply(
            bodyColor: const Color(0xFF2D2D32),
            displayColor: const Color(0xFF2D2D32),
          ),
        ),
        initialRoute: initialRoute,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case HomePageUI.TAG:
              return MaterialPageRoute(
                builder: (context) => HomePageUI(),
                settings: RouteSettings(name: settings.name),
              );
            case LoginPage.TAG:
              return MaterialPageRoute(
                builder: (context) => LoginPage(),
                settings: RouteSettings(name: settings.name),
              );
            default:
              return isLoggedIn
                  ? MaterialPageRoute(
                      builder: (context) => LoginPage(),
                      settings: RouteSettings(name: settings.name),
                    )
                  : MaterialPageRoute(
                      builder: (context) => HomePageUI(),
                      settings: RouteSettings(name: settings.name),
                    );
          }
        },
        home: isLoggedIn ? HomePageUI() : LoginPage());
  }
}
