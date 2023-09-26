import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trello_tasks_sync/bloc/user/bloc.dart';

class LoginPage extends StatelessWidget {
  final String error;
  final VoidCallback togglePage;

  LoginPage({super.key, required this.togglePage, required this.error});

  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: height * 0.50,
          width: width * 0.75,
          child: Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: userController,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    hintText: 'Username',
                    hintStyle: const TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: passController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    hintText: 'Password',
                    hintStyle: const TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 20,
                    ),
                  ),
                  onPressed: () {
                    final username = userController.text;
                    final password = passController.text;

                    if (username.isNotEmpty && password.isNotEmpty) {
                      authBloc.add(
                          LoginEvent(username: username, password: password));
                      userController.text = '';
                      passController.text = '';
                    }
                  },
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: togglePage,
          child: const Text('You do not have an account? Sign Up'),
        ),
      ],
    );
  }
}
