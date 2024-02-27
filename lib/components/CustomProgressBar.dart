import 'package:flutter/material.dart';
import 'package:flutter_basf_hk_app/styles/colors.dart';

class CustomProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5)),
      child: Container(
        padding: EdgeInsets.all(10),
        color: Color(colorPrimary),
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
          valueColor: AlwaysStoppedAnimation<Color>(Color(progressColor)),
        ),
      ),
    );
  }
}
