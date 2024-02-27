import 'package:flutter/material.dart';
import 'package:flutter_basf_hk_app/localization/LocaleUtils.dart';
import 'package:flutter_basf_hk_app/styles/colors.dart';

class PasswordInfoDialog extends StatefulWidget {
  final String? title;
  final String? title1;
  final String? title2;
  final String? title3;
  final String? title4;
  final VoidCallback? onPressedClose;
  int? color;

  PasswordInfoDialog({
    this.title,
    this.title1,
    this.title2,
    this.title3,
    this.title4,
    this.onPressedClose,
  });

  @override
  PasswordInfoDialogState createState() => PasswordInfoDialogState();
}

class PasswordInfoDialogState extends State<PasswordInfoDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Animation<double>? scaleAnimation;

  Widget textWidget(
      {required String title,
      double? textSize,
      FontWeight? fontWeight,
      Color? textColor}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: textSize ?? 14.0,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontFamily: 'Roboto',
        color: textColor ?? Colors.white,
      ),
      textAlign: TextAlign.left,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5.0,
      backgroundColor: Colors.white,
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
              child: textWidget(
                  title: widget.title!,
                  textSize: 16.0,
                  textColor: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/bullet.png',
                              width: 10,
                              height: 10,
                              color: Color(colorPrimary),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 10),
                                child: textWidget(
                                    title: widget.title1!,
                                    textSize: 15.0,
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/bullet.png',
                              width: 10,
                              height: 10,
                              color: Color(colorPrimary),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 10),
                                child: Center(
                                  child: textWidget(
                                      title: widget.title2!,
                                      textSize: 15.0,
                                      textColor: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/bullet.png',
                              width: 10,
                              height: 10,
                              color: Color(colorPrimary),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 10),
                                child: textWidget(
                                    title: widget.title3!,
                                    textSize: 15.0,
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/bullet.png',
                              width: 10,
                              height: 10,
                              color: Color(colorPrimary),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 10),
                                child: Center(
                                  child: textWidget(
                                      title: widget.title4!,
                                      textSize: 15.0,
                                      textColor: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 10, right: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onPressedClose!();
                  },
                  // textColor: Colors.white,
                  // color: Color(colorPrimary),
                  style: ElevatedButton.styleFrom(
                      primary: Color(colorPrimary),
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      )),
                  child: Text(
                    LocaleUtils.getString(context, 'save_small'),
                    style: TextStyle(color: Colors.white, fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
