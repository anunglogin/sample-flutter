import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigation_3/pages/login.dart';
import 'package:flutter_navigation_3/state/cubit/welcome_cubit.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => WelcomeCubit())],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Login(),
        ));
  }
}
