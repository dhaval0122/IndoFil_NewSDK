import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../Utils/CustomAppBar.dart';
import '../styles/colors.dart';


class WebViewScreen extends StatefulWidget {
  String url;

  WebViewScreen(this.url);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  BuildContext? mContext;
  Size? screenSize;
  InAppWebViewController? _webViewController;
  Position? currentLocation;
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();

    print('Url========${widget.url.contains('https')}');
    if (!widget.url.contains('https')) {
      if (!widget.url.contains('http')) {
        if (!widget.url.contains('i.ivcs.ai')) {
          widget.url = 'https://${widget.url}';
        } else {
          if (Platform.isIOS && widget.url.contains('i.ivcs.ai')) {
            widget.url = 'http://${widget.url}';
          }
        }
        print('Not contain http url =' + widget.url);
      }
    }
  }

  bool _isLoading = true;
  bool _isLoadingStart = true;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    mContext = context;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Color(0xFF6200EA)),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context, true);
            return Future.value(true);
          },
          child: Scaffold(
            appBar: CustomAppBar(false, true, () {
              Navigator.pop(context, true);
            }),
            body: Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        javaScriptEnabled: true,
                        useOnLoadResource: true,
                        mediaPlaybackRequiresUserGesture: false,
                          transparentBackground: true
                      ),
                    ),
                    onWebViewCreated: (controller) {
                      _webViewController = controller;
                    },
                    onLoadStart: (controller, url) {
                      setState(() {
                        _isLoadingStart = false;
                        _isLoading = true;
                      });
                    },
                    onLoadStop: (controller, url) async {
                      setState(() {
                        _isLoading = false;
                      });
                    },
                    onLoadError: (controller, url, code, message) {
                      print("Error loading page: $message");
                    },
                  ),
                  _isLoading
                      ? Center(
                    child: CircularProgressIndicator(),
                  )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
