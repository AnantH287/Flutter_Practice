import 'package:demo/Bloc/Bloc.dart';
import 'package:demo/Bloc/Event.dart';
import 'package:demo/Bloc/State.dart';
import 'package:demo/Screens/JWT/jwt_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => LoginBloc(),
        child:
        BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              final token = state.token;
              // Navigator.pushReplacementNamed(context, "/dashboard");
              Navigator.push(context, MaterialPageRoute(builder: (context)=>JwtHomeScreen(token: token)));
            }

            if (state is LoginFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          
          },
          builder: (context, state) {
            final bloc = BlocProvider.of<LoginBloc>(context);

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: emailCtrl,
                    decoration: InputDecoration(labelText: "Email"),
                  ),
                  TextField(
                    controller: passCtrl,
                    obscureText: true,
                    decoration: InputDecoration(labelText: "Password"),
                  ),
                  const SizedBox(height: 20),

                  state is LoginLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () {
                      bloc.add(LoginButtonPressed(
                        email: emailCtrl.text.trim(),
                        password: passCtrl.text.trim(),
                      ));
                    },
                    child: Text("Login"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
