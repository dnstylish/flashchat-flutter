import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/components/includes/rounded_button.dart';
import 'package:flashchat/components/includes/rounded_input.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late String _email;
  late String _password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedInput(
              placeholder: 'Enter your email',
              onChanged: (String value) {
                _email = value;
              }
            ),
            SizedBox(
              height: 8.0,
            ),
            RoundedInput(
                placeholder: 'Enter your password.',
                onChanged: (String value) {
                  _password = value;
                }
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              label: 'Login',
              onPressed: () async {
                try {
                  await  FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _email, password: _password);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(
                    content: Text('Đăng nhập thành công',
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.blueAccent,
                  ))
                      .closed
                      .then((value) => Navigator.of(context).pushNamed('/chat'));
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('$error',
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.blueAccent,
                  ));
                }
              },
              color: Colors.lightBlueAccent,
            )
          ],
        ),
      ),
    );
  }
}