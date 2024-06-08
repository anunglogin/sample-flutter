import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigation_3/cubit/cubit/auth_cubit.dart';
import 'package:flutter_navigation_3/pages/home.dart';
import 'package:flutter_navigation_3/state/cubit/welcome_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isVisible = true;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('is_logged_in') ?? false;
      if (isLoggedIn) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      }
    });
  }

  _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_logged_in', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Welcome to class flutter'),
                const SizedBox(height: 20),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                              labelText: 'Username',
                              contentPadding: EdgeInsets.all(15),
                              border: OutlineInputBorder()),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Silahkan isi username anda';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: isVisible,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              contentPadding: const EdgeInsets.all(15),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  },
                                  icon: (isVisible)
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off)),
                              border: const OutlineInputBorder()),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                      ],
                    )),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveData();

                      // context
                      //     .read<WelcomeCubit>()
                      //     .setData(_usernameController.text);

                      context.read<AuthCubit>().loginUser(
                          username: _usernameController.text,
                          password: _passwordController.text);
                    }
                  }, child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()));
                      } else if (state is AuthFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.message),
                            duration: const Duration(seconds: 2)));
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const CircularProgressIndicator();
                      } else {
                        return const Text('Login');
                      }
                    },
                  )),
                )
              ],
            ),
          ),
        ));
  }
}
