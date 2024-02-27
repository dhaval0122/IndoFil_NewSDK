import 'package:flutter/material.dart';

class CustomAlertLogDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final String? textPositiveButton;
  final String? textNagativeButton;
  final bool? isShowNagativeButton;
  final VoidCallback? onPressedNegative;
  final VoidCallback? onPressedPositive;
  final Color? colorVal;

  CustomAlertLogDialog(
      {this.title,
      this.content,
      this.textPositiveButton,
      this.textNagativeButton,
      this.isShowNagativeButton,
      this.onPressedNegative,
      this.onPressedPositive,
      this.colorVal});

  @override
  Widget build(BuildContext context) {
    List<Widget> _actionButton() {
      if (isShowNagativeButton!) {
        return <Widget>[
          TextButton(
            child: Text(
              textNagativeButton!,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black87,
                decoration: TextDecoration.none,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onPressedNegative!();
            },
          ),
          TextButton(
            child: Text(
              textPositiveButton!,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black87,
                decoration: TextDecoration.none,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onPressedPositive!();
            },
          ),
        ];
      } else {
        return <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: colorVal,
            ),
            child: Text(
              textPositiveButton!,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onPressedPositive!();
            },
          ),
        ];
      }
    }

    return AlertDialog(
        contentPadding: EdgeInsets.only(left: 25, right: 25),
        titlePadding: EdgeInsets.only(left: 25, top: 25, right: 25, bottom: 15),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        title: Text(
          title!,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black87,
            decoration: TextDecoration.none,
            fontSize: 15,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
        ),
        //title: new Text("Alert Dialog title"),
        content: Text(
          content!,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black87,
            decoration: TextDecoration.none,
            fontSize: 13,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: _actionButton());
  }
}
