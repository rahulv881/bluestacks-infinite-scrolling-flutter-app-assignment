import 'package:flutter/material.dart';

class HomePageUI extends StatefulWidget {
  static const TAG = "HOME PAGE UI";
  HomePageUI({Key? key}) : super(key: key);

  @override
  State<HomePageUI> createState() => _HomePageUIState();
}

class _HomePageUIState extends State<HomePageUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
