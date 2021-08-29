import 'package:flutter/material.dart';
import 'package:flashchat/components/includes/rounded_button.dart';
import 'package:flashchat/components/includes/rounded_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_overlay/loading_overlay.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String _email;
  late String _password;

  bool showSpin = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingOverlay(
        isLoading: showSpin,
        child: Padding(
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
                  }),
              SizedBox(
                height: 8.0,
              ),
              RoundedInput(
                  isPassword: true,
                  placeholder: 'Enter your password.',
                  onChanged: (String value) {
                    _password = value;
                  }),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  label: 'Sign Up',
                  onPressed: () async {
                    try {
                      setState(() {
                        showSpin = true;
                      });
                      await  FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: _email, password: _password);
                      Navigator.of(context).pushNamed('/chat');
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('$error',
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.blueAccent,
                      ));
                    }
                    setState(() {
                      showSpin = false;
                    });
                  },
                  color: Colors.blueAccent),
            ],
          ),
        ),
      ),
    );
  }
}
