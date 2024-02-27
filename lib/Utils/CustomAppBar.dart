import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basf_hk_app/styles/colors.dart';
import 'package:flutter_basf_hk_app/styles/dimens.dart';

import 'Utils.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool isShowDrawerIcon, isShowBack;
  final Function onClick;

  CustomAppBar(this.isShowDrawerIcon, this.isShowBack, this.onClick);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      // Set this height
      elevation: 0,
      backgroundColor: Color(colorPrimary),
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        color: Color(colorPrimary),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 15),
                alignment: AlignmentDirectional.center,
                child: InkWell(
                  onTap: () {
                    Utils.showAppInfoDialog(context);
                  },
                  child: Image.asset(Utils.getProjectIcon(),
                      width: login_logo_120, height: login_logo_120),
                )),
            Expanded(child: Container()),
            isShowDrawerIcon
                ? InkWell(
                    onTap: () {
                      onClick();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          right: 10, left: 10, top: 5, bottom: 5),
                      child: Icon(
                        Icons.delete,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  )
                : isShowBack
                    ? InkWell(
                        onTap: () {
                          onClick();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                              right: 10, left: 10, top: 5, bottom: 5),
                          child: Image.asset('assets/back_arrow.png',
                              width: 30, height: 30),
                        ),
                      )
                    : Container(),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(100.0);
}
