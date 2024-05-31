import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_navigation_3/database/DatabaseHelper.dart';
import 'package:flutter_navigation_3/model/Todo.dart';
import 'package:flutter_navigation_3/pages/login.dart';
import 'package:flutter_navigation_3/pages/product.dart';
import 'package:flutter_navigation_3/state/cubit/welcome_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  void _fetchTodos() async {
    final todos = await _dbHelper.getTodos();
    setState(() {
      _todos = todos;
    });
  }

  void _addTodo() async {
    await _dbHelper.insertTodo(Todo(
      title: 'Todo ${_todos.length}',
      description: 'Description ${_todos.length}',
    ));
    _fetchTodos();
  }

  void _toggleTodoStatus(Todo todo) async {
    todo.isDone = !todo.isDone;
    await _dbHelper.updateTodo(todo);
    _fetchTodos();
  }

  _clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    setState(() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          BlocBuilder<WelcomeCubit, WelcomeState>(
            builder: (context, state) {
              return Text(state.message);
            },
          ),
          ElevatedButton(
            onPressed: _addTodo,
            child: const Text('Add Todo'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Product()));
            },
            child: const Text('Product'),
          ),
          ElevatedButton(
            onPressed: _clearData,
            child: const Text('Logout'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.description),
                  trailing: Checkbox(
                    value: todo.isDone,
                    onChanged: (bool? value) {
                      _toggleTodoStatus(todo);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
