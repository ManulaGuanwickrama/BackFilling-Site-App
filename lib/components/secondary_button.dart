import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  SecondaryButton(
      {required this.clr, required this.title, required this.onPressFunction});

  final Color clr;
  final String title;
  final Function onPressFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: clr,
        borderRadius: BorderRadius.circular(15.0),
        child: MaterialButton(
          onPressed: () => onPressFunction(),
          minWidth: 100.0,
          height: 50.0,
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
