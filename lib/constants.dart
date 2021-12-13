import 'package:flutter/material.dart';

Color kAppBarColor = Color(0xff132641);
Color kBackgroundColor = Color(0xffffffff);
Color kLightColor = Color(0xff4F8DCB);
Color kMediumColor = Color(0xff4666E5);
Color kDarkPurpleColor = Color(0xff261835);
Color kTestPassColor = Color(0xff21ba45);
Color kTestPassCircleColor = Color(0xff1e561f);
Color kPendingColor = Color(0xfffbbd08);
Color kPendingCircleColor = Color(0xfff2711c);
Color kNotTestedColor = Color(0xff5f5f5f);
Color kNotTestedCircleColor = Colors.black87;

const kTestInputFieldDecoration = InputDecoration(
  hintText: 'Enter the value',
  contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

const kTextFieldDecorationDecoration = InputDecoration(
  hintText: 'Enter the value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
