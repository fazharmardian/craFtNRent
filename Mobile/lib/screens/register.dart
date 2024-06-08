import 'package:flutter/material.dart';
import 'login.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _telephone = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool obsecure = true;
  String? registerError;

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username cannot be empty';
    }
    return null;
  }

  String? validateEmail(String? value) {
    
  String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!regex.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validateTelephone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Telephone number cannot be empty';
    } else if (value.length < 8) {
      return 'Invalid Telephone Number';
    } else if (int.tryParse(value) == null) {
      return 'Invalid telephone number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      var url = Uri.parse('http://192.168.252.17/craftnrent/ApiV1/user/register.php');
      var response = await http.post(url, body: {
        "username": _username.text,
        "email": _email.text,
        "telephone": _telephone.text,
        "password": _password.text,
      });
      var data = json.decode(response.body);
      if (data["status"] == "success") {
        Fluttertoast.showToast(
          backgroundColor: Colors.green,
          textColor: Colors.white,
          msg: 'Registration Successful',
          toastLength: Toast.LENGTH_SHORT,
        );
        _username.clear();
        _email.clear();
        _telephone.clear();
        _password.clear();
      } else {
        setState(() {
          registerError = 'Username or Email is Already Registered';
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
                      controller: _username,
                      validator: validateUsername,
                      style: const TextStyle(
                        color: Colors.black38,
                        fontSize: 14.5,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIconConstraints: const BoxConstraints(minWidth: 45),
                        prefixIcon: const Icon(
                          Icons.person,
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
                        hintText: 'Your Username (e.g Aurora M0z)',
                        hintStyle: const TextStyle(
                          color: Colors.black38,
                          fontSize: 14.5,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        errorText: registerError,
                      ),
                    ),
                  ),
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
                        hintText: 'Your Email (e.g email@email.com)',
                        hintStyle: const TextStyle(
                          color: Colors.black38,
                          fontSize: 14.5,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        errorText: registerError,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30)
                        .copyWith(bottom: 10),
                    child: TextFormField(
                      controller: _telephone,
                      validator: validateTelephone,
                      style: const TextStyle(
                        color: Colors.black38,
                        fontSize: 14.5,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIconConstraints: const BoxConstraints(minWidth: 45),
                        prefixIcon: const Icon(
                          Icons.phone,
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
                        hintText: 'Your Telephone (0888666999)',
                        hintStyle: const TextStyle(
                          color: Colors.black38,
                          fontSize: 14.5,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        errorText: registerError,
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
                      obscureText: obsecure,
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
                              obsecure = !obsecure;
                            });
                          },
                          child: Icon(
                            obsecure ? Icons.visibility : Icons.visibility_off,
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
                        hintText: 'Your Password (at least 8 character)',
                        hintStyle: const TextStyle(
                          color: Colors.black38,
                          fontSize: 14.5,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        errorText: registerError,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30)
                        .copyWith(bottom: 10),
                    child: GestureDetector(
                      onTap: register,
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade900,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          'Register',
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
                        'Already have an account?',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                        child: const Text(
                          'Sign In',
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
