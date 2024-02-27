import 'package:flutter/material.dart';
import 'package:flutter_basf_hk_app/localization/LocaleUtils.dart';
import 'package:flutter_basf_hk_app/styles/dimens.dart';

class DrawerFooterWidgets extends StatelessWidget {
  String? version;

  DrawerFooterWidgets({this.version});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: p_20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              LocaleUtils.getString(context, "Poweredby"),
              style: TextStyle(
                fontSize: 14.0,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/drawer_logo.png',
                      width: p_100, height: bottom_height_50),
                  Padding(
                    child: Text(
                      "|",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    padding: EdgeInsets.only(left: p_10),
                  ),
                  Padding(
                    child: Text(
                      '${LocaleUtils.getString(context, "Version")} ${version ??
                          ''}',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    padding: EdgeInsets.only(left: p_10),
                  )
                ],
              ),
              padding: EdgeInsets.only(top: p_5),
            ),
          ],
        ),
      ),
    );
  }
}
