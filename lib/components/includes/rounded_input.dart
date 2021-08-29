import 'package:flutter/material.dart';

class RoundedInput extends StatelessWidget {
  const RoundedInput({Key? key, required this.placeholder, required this.onChanged, this.isPassword = false}) : super(key: key);

  final String placeholder;
  final ValueChanged<String>? onChanged;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      obscureText: isPassword,
      enableSuggestions: false,
      autocorrect: false,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black54
      ),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle:  TextStyle(
            color: Colors.black54
        ),
        contentPadding:
        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Colors.lightBlueAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: Colors.lightBlueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}
