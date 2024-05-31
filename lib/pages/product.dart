import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigation_3/state/cubit/welcome_cubit.dart';

class Product extends StatelessWidget {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
      ),
      body: Center(
        child: BlocBuilder<WelcomeCubit, WelcomeState>(
          builder: (context, state) {
            return Text('Halo Selamat Datang ${state.message}');
          },
        ),
      ),
    );
  }
}
