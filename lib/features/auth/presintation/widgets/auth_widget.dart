import 'package:e_commerce_app/features/auth/presintation/bloc/auth_bloc.dart';
import 'package:e_commerce_app/features/auth/presintation/bloc/auth_event.dart';
import 'package:e_commerce_app/features/auth/presintation/bloc/auth_state.dart';
import 'package:e_commerce_app/features/e_commerce_clean/presintation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AuthWidget extends StatelessWidget {
  bool doRegister;
  AuthWidget({super.key, required this.doRegister});
  TextEditingController emailField = TextEditingController();
  TextEditingController passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E commerce'),
        centerTitle: true,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStateLoading) {
            return _authWidget(context);
          } else if (state is AuthStateSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(userId: state.userId!),
                  ));
            });
          } else if (state is AuthStateLogOut) {
            return _authWidget(context);
          } else if (state is AuthStateException) {
            emailField.clear();
            passwordField.clear();

            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.exceptionMessage!),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(25)),
                  child: TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthLogOutEvent());
                    },
                    child: const Text(
                      "back",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ));
          }
          return _buildCircularIndicator();
        },
      ),
    );
  }

  Column _authWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Welcome',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        _buildTextField(
          'Email',
          Icons.email,
          false,
          TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        _buildTextField('Password', Icons.lock, true, TextInputType.text),
        const SizedBox(height: 20),
        _buildActionButton(context),
        const SizedBox(height: 16),
        doRegister ? const SizedBox() : _buildSwitchAuthMode(context),
      ],
    );
  }

  //! _buildSwitchAuthMode
  GestureDetector _buildSwitchAuthMode(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AuthWidget(doRegister: true),
            ));
      },
      child: const Text(
        "Don't have an account? Register",
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  //! _buildActionButton
  SizedBox _buildActionButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        onPressed: () {
          doRegister
              ? context.read<AuthBloc>().add(AuthRegisterEvent(
                  email: emailField.text, password: passwordField.text))
              : context.read<AuthBloc>().add(AuthLogInEvent(
                  email: emailField.text, password: passwordField.text));
        },
        child: doRegister
            ? const Text(
                'Register',
                style: TextStyle(fontSize: 18),
              )
            : const Text(
                'Log In',
                style: TextStyle(fontSize: 18),
              ),
      ),
    );
  }

  //! _buildTextField done
  TextField _buildTextField(String hintText, IconData icon, bool isPassword,
      TextInputType keyboardType) {
    return TextField(
      controller: isPassword ? passwordField : emailField,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  //! _buildCircularIndicator
  Padding _buildCircularIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
