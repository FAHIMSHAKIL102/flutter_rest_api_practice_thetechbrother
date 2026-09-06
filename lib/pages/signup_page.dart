import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignupPage extends StatefulWidget {
  const new({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, password) async {
    try {
      Response response = await post(
        Uri.parse('https://reqres.in/api/register'),
        body: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        print('Account created successfully');
        var data = jsonDecode(response.body.toString());
        print(data);
      } else {
        print('Failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('S I G N U P')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                login(
                  emailController.text.toString(),
                  passwordController.text.toString(),
                );
              },
              child: Container(
                height: 58,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(7),
                ),

                child: Center(child: Text('SignUp')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
