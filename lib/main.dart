import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_note/bloc/auth/auth_bloc.dart';
import 'package:to_note/bloc/todo/to_do_bloc.dart';
import 'package:to_note/firebase_options.dart';
import 'package:to_note/ui/screens/splash.dart';
import 'package:to_note/services/firestore/to_do_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate ToDoFirestore here
    final toDoFirestore = ToDoFirestore();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(firebaseAuth: FirebaseAuth.instance),
        ),
        BlocProvider<ToDoBloc>(
          create: (context) =>
              ToDoBloc(toDoFirestore), // Pass the instance here
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}


