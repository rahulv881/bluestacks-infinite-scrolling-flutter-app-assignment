import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assignment/ui/home/home_page_ui.dart';
import 'package:flutter_assignment/ui/login/bloc/login_page_ui_bloc.dart';
import 'package:flutter_assignment/widgets/custom_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static const TAG = "LOGIN PAGE UI";
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String errMsg = "";
  String password = "";
  String username = "";
  bool hidePassword = true;
  bool isAuthenticating = false;
  late LoginPageUiBloc _loginPageUiBloc;

  @override
  void initState() {
    super.initState();
    _loginPageUiBloc = LoginPageUiBloc();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => _loginPageUiBloc,
      child: Scaffold(
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
                    BlocConsumer<LoginPageUiBloc, LoginPageUiState>(
                      listener: (context, state) {
                        if (state is MobileNumberChangedState) {
                          username = state.username;
                        }
                        if (state is LoginPageErrorState) {
                          errMsg = state.errMsg;
                        }
                      },
                      builder: (context, state) {
                        //
                        return CustomTextField(
                          hintText: "Mobile Number",
                          maxLength: 10,
                          inputFormatter: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]*")),
                          ],
                          onEditingComplete: () => removeFocus(),
                          onChanged: (value) => {
                            _loginPageUiBloc
                                .add(ChangeMobileNumberEvent(username: value))
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 36.0),
                    BlocConsumer<LoginPageUiBloc, LoginPageUiState>(
                      listener: (context, state) {
                        if (state is PasswordChangedState) {
                          password = state.password;
                        }
                        if (state is LoginPageErrorState) {
                          errMsg = state.errMsg;
                        }
                      },
                      builder: (context, state) {
                        return CustomTextField(
                          hintText: "Password",
                          obscureText: hidePassword,
                          suffixIcon: hidePassword
                              ? IconButton(
                                  icon: const Icon(Icons.visibility_off),
                                  splashRadius: 24.0,
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = false;
                                    });
                                  })
                              : IconButton(
                                  icon: const Icon(Icons.visibility),
                                  splashRadius: 24.0,
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = true;
                                    });
                                  },
                                ),
                          onEditingComplete: () => removeFocus(),
                          onChanged: (value) => {
                            _loginPageUiBloc
                                .add(ChangePasswordEvent(password: value))
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 24.0),
                    BlocConsumer<LoginPageUiBloc, LoginPageUiState>(
                      listener: (context, state) {
                        if (state is LoginPageErrorState) {
                          errMsg = state.errMsg;
                        }
                        if (state is UserAuthenticatedSuccefullyState) {
                          errMsg = "";
                        }
                      },
                      builder: (context, state) {
                        if (errMsg.isNotEmpty) {
                          return Text(
                            errMsg,
                            maxLines: 2,
                            style: const TextStyle(color: Colors.red),
                          );
                        }
                        return Container(
                          height: 32.0,
                        );
                      },
                    ),
                    const SizedBox(height: 24.0),
                    BlocConsumer<LoginPageUiBloc, LoginPageUiState>(
                      listener: (context, state) {
                        if (state is AuthenticatingUserCredentialsState) {
                          isAuthenticating = true;
                        }
                        if (state is UserAuthenticatedSuccefullyState) {
                          isAuthenticating = false;
                          Navigator.of(context).pushNamed(HomePageUI.TAG);
                        }
                        if (state is LoginPageErrorState) {
                          errMsg = state.errMsg;
                          isAuthenticating = false;
                        }
                      },
                      builder: (context, state) {
                        return isAuthenticating
                            ? SizedBox(
                                height: 48.0,
                                width: 48.0,
                                child: CircularProgressIndicator(
                                  color: theme.primaryColor,
                                ),
                              )
                            : SizedBox(
                                height: 48.0,
                                width: MediaQuery.of(context).size.width,
                                child: Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _loginPageUiBloc.add(
                                        LoginUserEvent(
                                          username: username,
                                          password: password,
                                        ),
                                      );
                                    },
                                    child: const Text("Login"),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                    ),
                                  ),
                                ),
                              );
                      },
                    ),
                  ],
                ),
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
