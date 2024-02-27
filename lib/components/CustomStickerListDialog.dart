import 'package:flutter/material.dart';

class CustomStickerListAlertDialog extends StatefulWidget {
  final String? title;
  final Color? cancelColor;
  final String? text1;
  final Color? textColor1;
  final VoidCallback? onPressedCancel;
  final VoidCallback? onPressedClose;
  Widget? listview;

  CustomStickerListAlertDialog(
      {this.title,
      this.cancelColor,
      this.text1,
      this.textColor1,
      this.onPressedCancel,
      this.onPressedClose,
      this.listview});

  @override
  CustomStickerListAlertDialogState createState() =>
      CustomStickerListAlertDialogState();
}

class CustomStickerListAlertDialogState
    extends State<CustomStickerListAlertDialog>
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
        fontSize: textSize ?? 14.0,
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
            height: MediaQuery.of(context).size.height / 2,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: textWidget(
                            title: widget.title!,
                            textSize: 16.0,
                            textColor: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(flex: 3, child: widget.listview!),
                    Expanded(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Spacer(
                            flex: 1,
                          ),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: widget.cancelColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    textStyle: TextStyle(
                                      color: widget.textColor1,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                    )),
                                child: textWidget(
                                    title: widget.text1!,
                                    textSize: 16.0,
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.w500),
                                // elevation: 5,
                                // textColor: widget.textColor1,
                                onPressed: () {
                                  //Navigator.of(context).pop();
                                  widget.onPressedCancel!();
                                }),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                        ],
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
