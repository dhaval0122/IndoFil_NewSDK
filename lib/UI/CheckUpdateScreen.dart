import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basf_hk_app/Utils/CustomAppBar.dart';
import 'package:flutter_basf_hk_app/Utils/Utils.dart';
import 'package:flutter_basf_hk_app/localization/LocaleUtils.dart';
import 'package:flutter_basf_hk_app/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckUpdateScreen extends StatefulWidget {
  final String? file_download_url;

  CheckUpdateScreen(this.file_download_url);

  @override
  _CheckUpdateScreenState createState() => _CheckUpdateScreenState();
}

class _CheckUpdateScreenState extends State<CheckUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(colorPrimary)),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            appBar: CustomAppBar(false, true, () {}),
            body: Container(
              color: Color(colorPrimary),
              child: Container(
                padding: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              LocaleUtils.getString(context, 'checkupdatemsg1'),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15,fontFamily: 'Roboto',fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              LocaleUtils.getString(context, 'checkupdatemsg2'),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15,fontFamily: 'Roboto',fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              LocaleUtils.getString(context, 'checkupdatemsg3'),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15,fontFamily: 'Roboto',fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                LocaleUtils.getString(
                                    context, 'checkupdatemsg4'),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15,fontFamily: 'Roboto',fontWeight: FontWeight.w500),
                              )),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        // if (widget.file_download_url!.isNotEmpty) {
                        //   if (await canLaunchUrl(
                        //       Uri.parse(widget.file_download_url!))) {
                        //     await launchUrl(
                        //         Uri.parse(widget.file_download_url!),
                        //         mode: LaunchMode.externalApplication);
                        //   }
                        // } else {
                        //   Utils.showToastMessage("File download url is empty");
                        // }
                        if (Platform.isAndroid) {
                          Utils.checkForUpdatesFromPlayStore();
                        } else if (Platform.isIOS) {
                          if (await canLaunchUrl(Uri.parse(
                              'https://apps.apple.com/in/app/indofil-qr/id1626079737'))) {
                            await launchUrl(
                                Uri.parse(
                                    'https://apps.apple.com/in/app/indofil-qr/id1626079737'),
                                mode: LaunchMode.externalApplication);
                          } else {
                            throw 'Could not launch ${widget.file_download_url!}';
                          }
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(colorPrimary),
                        ),
                        child: Text(
                          LocaleUtils.getString(context, 'Download'),
                          style: TextStyle(color: Colors.white,fontFamily: 'Roboto',fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
