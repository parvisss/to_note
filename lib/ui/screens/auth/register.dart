// registration_screen.dart
import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_note/bloc/auth/auth_bloc.dart';
import 'package:to_note/bloc/auth/auth_event.dart';
import 'package:to_note/bloc/auth/auth_state.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: BlocConsumer<AuthBloc, AuthState>(
  //         listener: (context, state) {
  //           if (state is AuthAuthenticated) {
  //             // Navigate to the home screen or any other screen on success
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               const SnackBar(content: Text('Registered successfully!')),
  //             );
  //             Navigator.pop(context); // Navigate back to the login screen
  //           } else if (state is AuthError) {
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(content: Text(state.error)),
  //             );
  //           }
  //         },
  //         builder: (context, state) {
  //           if (state is AuthLoading) {
  //             return Center(child: CircularProgressIndicator());
  //           }
  //           return Column(
  //             crossAxisAlignment: CrossAxisAlignment.stretch,
  //             children: [
  //               TextField(
  //                 controller: _emailController,
  //                 decoration: InputDecoration(labelText: 'Email'),
  //                 keyboardType: TextInputType.emailAddress,
  //               ),
  //               TextField(
  //                 controller: _passwordController,
  //                 decoration: InputDecoration(labelText: 'Password'),
  //                 obscureText: true,
  //               ),
  //               SizedBox(height: 20),
  //               ElevatedButton(
  //                 onPressed: () {
  //                   final email = _emailController.text.trim();
  //                   final password = _passwordController.text.trim();
  //                   if (email.isNotEmpty && password.isNotEmpty) {
  //                     context.read<AuthBloc>().add(
  //                           SignUpRequested(email: email, password: password),
  //                         );
  //                   } else {
  //                     ScaffoldMessenger.of(context).showSnackBar(
  //                       SnackBar(content: Text('Please enter email and password')),
  //                     );
  //                   }
  //                 },
  //                 child: Text('Register'),
  //               ),
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context); // Go back to the login screen
  //                 },
  //                 child: Text('Already have an account? Login here'),
  //               ),
  //             ],
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
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
        child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AuthAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Registered Successfully!"),
              ),
            );
            Navigator.pop(context);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        }, builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
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
                        topRight: Radius.circular(60),
                      ),
                    ),
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
                                    color: Color.fromRGBO(225, 95, 27, .3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10),
                                  )
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200),
                                      ),
                                    ),
                                    child: TextField(
                                      controller: nameController,
                                      decoration: const InputDecoration(
                                        hintText: "Fullname",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200),
                                      ),
                                    ),
                                    child: TextField(
                                      controller: emailController,
                                      decoration: const InputDecoration(
                                        hintText: "Email or Phone number",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200),
                                      ),
                                    ),
                                    child: TextField(
                                      controller: passwordController,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200),
                                      ),
                                    ),
                                    child: TextField(
                                      controller: confirmPasswordController,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        hintText: "Confirm Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1600),
                            child: MaterialButton(
                              onPressed: () {
                                const Center(
                                  child: CircularProgressIndicator(),
                                );
                                if (emailController.text.trim().isNotEmpty &&
                                    passwordController.text.trim().isNotEmpty &&
                                    confirmPasswordController.text ==
                                        passwordController.text &&
                                    nameController.text.isNotEmpty) {
                                  context.read<AuthBloc>().add(
                                        SignUpRequested(
                                            email: emailController.text,
                                            password: passwordController.text),
                                      );
                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Please enter email and password'),
                                    ),
                                  );
                                }
                              },
                              height: 50,
                              color: Colors.orange[900],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1500),
                            child: RichText(
                              text: TextSpan(
                                  text: "Already have an account?",
                                  style: const TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: " Log In",
                                        style:
                                            const TextStyle(color: Colors.blue),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pop(context);
                                          })
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: FadeInUp(
                                  duration: const Duration(milliseconds: 1800),
                                  child: MaterialButton(
                                    onPressed: () {},
                                    height: 50,
                                    color: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Facebook",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: FadeInUp(
                                  duration: const Duration(milliseconds: 1900),
                                  child: MaterialButton(
                                    onPressed: () {},
                                    height: 50,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
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
                                  ),
                                ),
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
        }),
      ),
    );
  }
}
