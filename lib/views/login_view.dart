import 'package:flutter/material.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(
              context,
              'Cannot find user with the entered credentials!',
            );
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(
              context,
              'Wrong Credentials',
            );
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(
              context,
              'Authentication Error',
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Please login with email to your account to interact with and create notes!'),
              ),
              TextField(
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Enter your email",
                    border: OutlineInputBorder(),
                  )),
              const SizedBox(height: 10,),
              TextField(
                  controller: _password,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintText: "Enter your password",
                    border: OutlineInputBorder(),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            const AuthEventForgotPassword(),
                          );
                    },
                    child: const Text("Forgot password?"),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    context.read<AuthBloc>().add(
                          AuthEventLogIn(
                            email,
                            password,
                          ),
                        );
                  },
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 18.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0),
                    ),
                    backgroundColor: Colors.blueGrey, 
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Login')),
              const SizedBox(height: 20,),
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventShouldRegister(),
                      );
                },
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                child: const Text("Not registered yet? Register here!"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
