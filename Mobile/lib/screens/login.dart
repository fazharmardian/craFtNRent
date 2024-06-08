import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool obscure = true;
  String? loginError;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    return null;
  }

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      var url = Uri.parse('http://192.168.252.17/craftnrent/ApiV1/user/login.php');
      var response = await http.post(url, body: {
        "email": _email.text,
        "password": _password.text,
      });

      print(response.body);

      var data = json.decode(response.body);
      if (data["message"] == "Success") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', data['user_id']);
        Navigator.push(
          context, MaterialPageRoute(builder: ((context) => DashboardPage())));
      } else {
        setState(() {
          loginError = 'Invalid email or password';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade900,
                Colors.black,
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 150,
                      width: 300,
                      child: Image.asset(
                        'images/craftnrent-medium.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30)
                        .copyWith(bottom: 10),
                    child: TextFormField(
                      controller: _email,
                      validator: validateEmail,
                      style: const TextStyle(
                        color: Colors.black38,
                        fontSize: 14.5,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIconConstraints: const BoxConstraints(minWidth: 45),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.black38,
                          size: 22,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        hintText: 'Your Email',
                        hintStyle: const TextStyle(
                          color: Colors.black38,
                          fontSize: 14.5,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        errorText: loginError,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30)
                        .copyWith(bottom: 10),
                    child: TextFormField(
                      controller: _password,
                      validator: validatePassword,
                      style: const TextStyle(
                        color: Colors.black38,
                        fontSize: 14.5,
                      ),
                      obscureText: obscure,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIconConstraints: const BoxConstraints(minWidth: 45),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.black38,
                          size: 22,
                        ),
                        suffixIconConstraints:
                            const BoxConstraints(minWidth: 45, maxWidth: 46),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                          child: Icon(
                            obscure ? Icons.visibility : Icons.visibility_off,
                            color: Colors.black38,
                            size: 22,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        hintText: 'Your Password',
                        hintStyle: const TextStyle(
                          color: Colors.black38,
                          fontSize: 14.5,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        errorText: loginError,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30)
                        .copyWith(bottom: 10),
                    child: GestureDetector(
                      onTap: login,
                      child: Container(
                        height: 45,
                        width:double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade900,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => RegisterPage())));
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
