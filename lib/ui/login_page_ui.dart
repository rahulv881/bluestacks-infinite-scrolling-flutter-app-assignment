import 'package:flutter/material.dart';
import 'package:flutter_assignment/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // * Remove focus and close keyboard for ios devices.
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomTextField(
                    hintText: "Mobile Number",
                    onEditingComplete: () => removeFocus(),
                    onChanged: (value) => {},
                  ),
                  const SizedBox(height: 36.0),
                  CustomTextField(
                    hintText: "Password",
                    onEditingComplete: () => removeFocus(),
                  ),
                  const SizedBox(height: 72.0),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Login"),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  removeFocus() {
    FocusScope.of(context).nextFocus();
  }
}
