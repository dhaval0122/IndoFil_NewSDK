import 'package:flutter/material.dart';

class CustomScanAlertDialog extends StatefulWidget {
  final String? title;
  final String? title1;
  final String? title2;
  final String? title3;
  final bool? text1;
  final bool? text2;
  final bool? text3;
  final String? imagePath;
  final Color? titleColor;
  final Color? title1Color;
  final Color? title2Color;
  final Color? title3Color;
  final VoidCallback? onPressedClose;

  CustomScanAlertDialog(
      {this.title,
      this.title1,
      this.title2,
      this.title3,
      this.text1,
      this.text2,
      this.text3,
      this.imagePath,
      this.titleColor,
      this.title1Color,
      this.title2Color,
      this.title3Color,
      this.onPressedClose});

  @override
  CustomScanAlertDialogState createState() => CustomScanAlertDialogState();
}

class CustomScanAlertDialogState extends State<CustomScanAlertDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  Widget textWidget(
      {required String title, double? textSize, FontWeight? fontWeight, Color? textColor}) {
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
    return ScaleTransition(
        scale: scaleAnimation,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5.0,
          backgroundColor: Colors.white,
          child: Container(
            height: MediaQuery.of(context).size.height / 3 + 50,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.onPressedClose!();
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 15, top: 15),
                      child: Image.asset(
                        'assets/popup_close_icon.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Visibility(
                      visible: widget.text3!,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: textWidget(
                          title: widget.title3!,
                          textSize: 20.0,
                          textColor: widget.title3Color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    /*Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: textWidget(
                          title: widget.title,
                          textSize: 20.0,
                          textColor: widget.titleColor,
                          fontWeight: FontWeight.bold),
                    ),*/
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        padding:
                            const EdgeInsets.only(top: 7, right: 40, left: 40),
                        child: Image.asset(
                          widget.imagePath.toString(),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.text1!,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: textWidget(
                            title: widget.title1!,
                            textSize: 20.0,
                            textColor: widget.title1Color,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Visibility(
                      visible: widget.text2!,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Center(
                          child: textWidget(
                            title: widget.title2!,
                            textSize: 18.0,
                            textColor: widget.title2Color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
