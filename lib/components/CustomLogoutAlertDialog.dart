import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basf_hk_app/Utils/Utils.dart';

class CustomLogoutAlertDialog extends StatefulWidget {
  final String? title;
  final String? title4;
  final String? text;
  final String? text1;
  final Color? confirmColor;
  final Color? cancelColor;
  final Color? textColor;
  final Color? textColor1;
  final VoidCallback? onPressedClose;
  final VoidCallback? onPressedConfirm;
  final VoidCallback? onPressedCancel;
  final Widget? listview;
  final bool? isValid;

  CustomLogoutAlertDialog(
      {this.title,
      this.title4,
      this.text,
      this.text1,
      this.confirmColor,
      this.cancelColor,
      this.textColor,
      this.textColor1,
      this.onPressedClose,
      this.listview,
      this.onPressedConfirm,
      this.onPressedCancel,
      this.isValid});

  @override
  CustomLogoutAlertDialogState createState() => CustomLogoutAlertDialogState();
}

class CustomLogoutAlertDialogState extends State<CustomLogoutAlertDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  Widget textWidget(
      {required String title,
      double? textSize,
      FontWeight? fontWeight,
      Color? textColor}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: textSize ?? 15.0,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontFamily: 'Roboto',
        color: textColor ?? Colors.white,
      ),
      textAlign: TextAlign.center,
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
            height: MediaQuery.of(context).size.height / 5,
            child: Stack(
              children: <Widget>[
                Visibility(
                  visible: false,
                  child: Align(
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
                ),
                Column(
                  children: <Widget>[
                    Visibility(
                      visible: false,
                      child: Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: textWidget(
                                title: widget.title!,
                                textSize: 16.0,
                                textColor: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 17),
                        child: Center(
                          child: textWidget(
                              title: widget.title4!,
                              textSize: 14.0,
                              textColor: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: ElevatedButton(
                                  // color: widget.confirmColor,
                                  // shape: RoundedRectangleBorder(
                                  //   borderRadius: BorderRadius.circular(10.0),
                                  // ),
                                  // elevation: 5,
                                  // textColor: widget.textColor,
                                  onPressed: () {
                                    widget.onPressedConfirm!();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    backgroundColor: widget.confirmColor,
                                    textStyle:
                                        TextStyle(color: widget.textColor),
                                  ),
                                  child: textWidget(
                                      title: widget.text!,
                                      textSize: 16.0,
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Utils.horizontalSpaceSmall,
                            Expanded(
                              child: ElevatedButton(
                                  // color: widget.cancelColor,
                                  // shape: RoundedRectangleBorder(
                                  //   borderRadius: BorderRadius.circular(10.0),
                                  // ),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    backgroundColor: widget.cancelColor,
                                    textStyle:
                                        TextStyle(color: widget.textColor1),
                                  ),
                                  // elevation: 5,
                                  // textColor: widget.textColor1,
                                  onPressed: () {
                                    //Navigator.of(context).pop();
                                    widget.onPressedCancel!();
                                  },
                                  child: textWidget(
                                      title: widget.text1!,
                                      textSize: 16.0,
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
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

class CustomDeleteAlertDialog extends StatefulWidget {
  final String? title;
  final String? title4;
  final String? text;
  final String? text1;
  final Color? confirmColor;
  final Color? cancelColor;
  final Color? textColor;
  final Color? textColor1;
  final VoidCallback? onPressedClose;
  final VoidCallback? onPressedConfirm;
  final VoidCallback? onPressedCancel;
  final Widget? listview;
  final bool? isValid;

  CustomDeleteAlertDialog(
      {this.title,
      this.title4,
      this.text,
      this.text1,
      this.confirmColor,
      this.cancelColor,
      this.textColor,
      this.textColor1,
      this.onPressedClose,
      this.listview,
      this.onPressedConfirm,
      this.onPressedCancel,
      this.isValid});

  @override
  CustomDeleteAlertDialogState createState() => CustomDeleteAlertDialogState();
}

class CustomDeleteAlertDialogState extends State<CustomDeleteAlertDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  Widget textWidget(
      {required String title,
      double? textSize,
      FontWeight? fontWeight,
      Color? textColor}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: textSize ?? 15.0,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontFamily: 'Roboto',
        color: textColor ?? Colors.white,
      ),
      textAlign: TextAlign.center,
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
            height: MediaQuery.of(context).size.height / 4,
            child: Stack(
              children: <Widget>[
                Visibility(
                  visible: false,
                  child: Align(
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
                ),
                Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: textWidget(
                              title: widget.title!,
                              textSize: 16.0,
                              textColor: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: textWidget(
                            title: widget.title4!,
                            textSize: 14.0,
                            textColor: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: widget.confirmColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      textStyle:
                                          TextStyle(color: widget.textColor)),
                                  child: textWidget(
                                      title: widget.text!,
                                      textSize: 16.0,
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.w500),
                                  // elevation: 5,
                                  // textColor: widget.textColor,
                                  onPressed: () {
                                    widget.onPressedConfirm!();
                                  }),
                            ),
                            Utils.horizontalSpaceSmall,
                            Expanded(
                              child: ElevatedButton(
                                  // color: widget.cancelColor,
                                  // shape: RoundedRectangleBorder(
                                  //   borderRadius: BorderRadius.circular(10.0),
                                  // ),
                                  child: textWidget(
                                      title: widget.text1!,
                                      textSize: 16.0,
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.w500),
                                  style: ElevatedButton.styleFrom(
                                      primary: widget.cancelColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      textStyle:
                                          TextStyle(color: widget.textColor1)),
                                  // elevation: 5,
                                  // textColor: widget.textColor1,
                                  onPressed: () {
                                    //Navigator.of(context).pop();
                                    widget.onPressedCancel!();
                                  }),
                            ),
                          ],
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
