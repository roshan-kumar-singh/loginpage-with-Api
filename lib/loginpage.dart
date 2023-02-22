import 'package:http/http.dart';
import 'package:untitled5/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


import 'homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;
   String? errorMessage;

  Future<UserModel> login(String username, String password) async {
    var uri =Uri.parse('https://bodhiai.live/api/membership/login_teacher/');
    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "password": password,
        }));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      print(response.body);
      return UserModel.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to login');
    }
  }

  _login() async {

    final uri = Uri.parse('https://bodhiai.live/api/membership/login_teacher/');
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {'id': 21, 'name': 'bob'};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print(responseBody);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
                validator: (value) {
                  String input = value as String;
                  if (input==null||input=='') {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                validator: (value) {
                  String input = value as String;
                  if (input ==null || input=='') {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              if (errorMessage != null)
                Text(
                  errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                           login(usernameController.text, passwordController.text);
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString('username', usernameController.text);
                      prefs.setString('password', passwordController.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  HomePage(),
                        ),
                      );
                      //Navigator.pushNamed(context, '/home');
                    } catch (e) {
                      setState(() {
                        _isLoading = false;
                        errorMessage = 'Login failed';
                      });
                    }
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






