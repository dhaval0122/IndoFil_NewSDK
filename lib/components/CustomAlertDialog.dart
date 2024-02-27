import 'package:flutter/material.dart';
import 'package:flutter_basf_hk_app/styles/colors.dart';

class CustomAlertDialog extends StatefulWidget {
  final String? title;
  final String? title1;
  final String? title2;
  final String? title3;
  final String? title4;
  final String? imagePath;
  final bool? isShowSocialMediaIcon;
  final VoidCallback? onPressedClose;

  CustomAlertDialog(
      {this.title,
      this.title1,
      this.title2,
      this.title3,
      this.title4,
      this.imagePath,
      this.isShowSocialMediaIcon,
      this.onPressedClose});

  @override
  CustomAlertDialogState createState() => CustomAlertDialogState();
}

class CustomAlertDialogState extends State<CustomAlertDialog>
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
            height: widget.isShowSocialMediaIcon!
                ? MediaQuery.of(context).size.height / 2 + 50
                : MediaQuery.of(context).size.height / 2,
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
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: textWidget(
                          title: widget.title!,
                          textSize: 16.0,
                          textColor: Colors.black54,
                          fontWeight: FontWeight.w400),
                    ),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: textWidget(
                          title: widget.title1!,
                          textSize: 20.0,
                          textColor: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
                        child: textWidget(
                            title: widget.title2!,
                            textSize: 14.0,
                            textColor: Colors.black54,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: textWidget(
                          title: widget.title3!,
                          textSize: 16.0,
                          textColor: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    widget.isShowSocialMediaIcon!
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: textWidget(
                                title: widget.title4!,
                                textSize: 16.0,
                                textColor: Colors.black54,
                                fontWeight: FontWeight.w500),
                          )
                        : Container(),
                    widget.isShowSocialMediaIcon!
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.only(top: 7),
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              const Color(colorPrimaryTrans)),
                                    ),
                                    Center(
                                      child: Image.asset(
                                        'assets/facebook_popup_icon.png',
                                        width: 15,
                                        height: 15,
                                      ),
                                    ),
                                  ],
                                  alignment: Alignment.center,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.only(top: 7),
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                const Color(colorPrimaryTrans)),
                                      ),
                                      Center(
                                        child: Image.asset(
                                          'assets/insta_popup_icon.png',
                                          width: 15,
                                          height: 15,
                                        ),
                                      ),
                                    ],
                                    alignment: Alignment.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.only(top: 7),
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                const Color(colorPrimaryTrans)),
                                      ),
                                      Center(
                                        child: Image.asset(
                                          'assets/linkedin_popup_icon.png',
                                          width: 15,
                                          height: 15,
                                        ),
                                      ),
                                    ],
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
