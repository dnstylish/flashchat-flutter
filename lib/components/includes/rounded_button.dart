import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({ Key? key, required this.label, required this.onPressed, required this.color }) : super(key: key);

  final String label;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: TextButton(
        onPressed: onPressed,
        child: Text(label),
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          minimumSize: Size(200, 42)
        ),
      ),
    );
  }
}
