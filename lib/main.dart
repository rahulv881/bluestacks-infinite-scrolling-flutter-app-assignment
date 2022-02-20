import 'package:flutter/material.dart';
import 'package:flutter_assignment/ui/home/home_page_ui.dart';
import 'package:flutter_assignment/ui/login/login_page_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLoggedIn = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

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
          primaryColor: Colors.lightBlue[800],
          fontFamily: 'Roboto',
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0),
            headline6: TextStyle(fontSize: 36.0),
            bodyText1: TextStyle(fontSize: 16.0),
            bodyText2: TextStyle(fontSize: 14.0),
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
