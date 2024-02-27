import 'package:flutter/material.dart';
import 'package:flutter_basf_hk_app/localization/LocaleUtils.dart';
import 'package:flutter_basf_hk_app/styles/colors.dart';
import 'package:flutter_basf_hk_app/styles/dimens.dart';

class FooterWidgets extends StatelessWidget {
  String? version;

  FooterWidgets({this.version});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(colorAccent)),
        padding: EdgeInsets.only(top: p_10, bottom: p_10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              LocaleUtils.getString(context, "Poweredby"),
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            Image.asset(
              'assets/footer_logo.png',
              width: p_100,
              height: bottom_height_50,
            ),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                '|',
                style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              LocaleUtils.getString(context, "Version") + " ${version ?? ''}",
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
