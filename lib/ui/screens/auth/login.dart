// login_screen.dart
import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_note/bloc/auth/auth_bloc.dart';
import 'package:to_note/bloc/auth/auth_event.dart';
import 'package:to_note/bloc/auth/auth_state.dart';
import 'package:to_note/ui/screens/auth/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.orange.shade900,
              Colors.orange.shade800,
              Colors.orange.shade400
            ],
          ),
        ),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logged in successfully!'),
                ),
              );
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeInUp(
                            duration: const Duration(milliseconds: 1000),
                            child: const Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeInUp(
                            duration: const Duration(milliseconds: 1300),
                            child: const Text(
                              "Welcome Back",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1400),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60))),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 60,
                            ),
                            FadeInUp(
                                duration: const Duration(milliseconds: 1400),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                            color:
                                                Color.fromRGBO(225, 95, 27, .3),
                                            blurRadius: 20,
                                            offset: Offset(0, 10))
                                      ]),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color:
                                                        Colors.grey.shade200))),
                                        child: TextField(
                                          controller: emailController,
                                          decoration: const InputDecoration(
                                              hintText: "Email",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color:
                                                        Colors.grey.shade200))),
                                        child: TextField(
                                          obscureText: true,
                                          controller: passwordController,
                                          decoration: const InputDecoration(
                                              hintText: "Password",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            const SizedBox(
                              height: 40,
                            ),
                            FadeInUp(
                                duration: const Duration(milliseconds: 1500),
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Colors.grey),
                                )),
                            const SizedBox(
                              height: 40,
                            ),
                            FadeInUp(
                                duration: const Duration(milliseconds: 1600),
                                child: MaterialButton(
                                  onPressed: () {
                                    if (emailController.text
                                            .trim()
                                            .isNotEmpty &&
                                        passwordController.text
                                            .trim()
                                            .isNotEmpty) {
                                      context.read<AuthBloc>().add(
                                          SignInRequested(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text));
                                    }
                                  },
                                  height: 50,
                                  color: Colors.orange[900],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              height: 50,
                            ),
                            FadeInUp(
                              duration: const Duration(milliseconds: 1700),
                              child: RichText(
                                text: TextSpan(
                                  text: "Don't have an account? ",
                                  style: const TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: 'Sign Up',
                                      style:
                                          const TextStyle(color: Colors.blue),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (ctx) =>
                                                  const RegistrationScreen(),
                                            ),
                                          );
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: FadeInUp(
                                      duration:
                                          const Duration(milliseconds: 1800),
                                      child: MaterialButton(
                                        onPressed: () {},
                                        height: 50,
                                        color: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Facebook",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: FadeInUp(
                                      duration:
                                          const Duration(milliseconds: 1900),
                                      child: MaterialButton(
                                        onPressed: () {},
                                        height: 50,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        color: Colors.black,
                                        child: const Center(
                                          child: Text(
                                            "Google",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
