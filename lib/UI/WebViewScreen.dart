import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basf_hk_app/Prefs/SharedPrefs.dart';
import 'package:flutter_basf_hk_app/Utils/CustomAppBar.dart';
import 'package:flutter_basf_hk_app/Utils/Utils.dart';
import 'package:flutter_basf_hk_app/blocs/WebViewScreenBloc.dart';
import 'package:flutter_basf_hk_app/components/CustomProgressBar.dart';
import 'package:flutter_basf_hk_app/localization/LocaleUtils.dart';
import 'package:flutter_basf_hk_app/styles/colors.dart';
import 'package:flutter_basf_hk_app/webservices/Constant.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  String url;

  WebViewScreen(this.url);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  BuildContext? mContext;
  Size? screenSize;
  WebViewScreenBloc? webViewScreenBloc;
  SharedPrefs? sharedPrefs;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  Position? currentLocation;
  DateTime? currentBackPressTime;

  // bool isLoading = false;

  @override
  void initState() {
    super.initState();
    sharedPrefs = SharedPrefs();
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    // setState(() {
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
      // else if (widget.url.contains('http')) {
      //   if (!widget.url.contains('i.ivcs.ai')) {
      //     if(Constant.SERVER =='IQA' || Constant.SERVER =='CQA') {
      //       widget.url = widget.url.replaceAll('http', 'https');
      //     }
      //   }
      //   print('contain http url =' + widget.url);
      // }
    }
    //
    print('Url=' + widget.url);
    // });
  }

  // int? _stackToView = 1;

  void _handleLoad(String value) {
    print("onPageFinished $value");
    webViewScreenBloc!.setLoadingStatus(false);
    // webViewScreenBloc!.setBusy(false);
    // setState(() {
    //   _stackToView = 0;
    // });
  }

  // InAppWebViewController? controller;

  // InAppWebViewSettings settings = InAppWebViewSettings(
  //   useShouldOverrideUrlLoading: true,
  //   mediaPlaybackRequiresUserGesture: false,
  //   allowsInlineMediaPlayback: true,
  //   useHybridComposition: true,
  //   clearCache: true,
  //   supportZoom: true,
  //   transparentBackground: true,
  //   javaScriptEnabled: true,
  // );
  bool _isLoading = true;
  bool _isLoadingStart = true;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    mContext = context;
    return ChangeNotifierProvider<WebViewScreenBloc>(
        create: (BuildContext context) => WebViewScreenBloc(context),
        child: Consumer(builder: (BuildContext context,
            WebViewScreenBloc webViewScreenBloc, Widget? child) {
          this.webViewScreenBloc = webViewScreenBloc;
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value:
                const SystemUiOverlayStyle(statusBarColor: Color(colorPrimary)),
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
                      Container(
                        color: Color(colorPrimary),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25))),
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 10, right: 10),
                            // margin: EdgeInsets.only(top: 25),
                            child: Stack(
                              children: [
                                WebView(
                                  initialUrl: widget.url,
                                  backgroundColor: Colors.white,
                                  javascriptMode: JavascriptMode.unrestricted,
                                  initialMediaPlaybackPolicy:
                                      AutoMediaPlaybackPolicy.always_allow,
                                  // onProgress: (int data) {
                                  //   if (data == 100) {
                                  //     // setState(() {
                                  //     //   isLoading = false;
                                  //     // });
                                  //   }
                                  // },
                                  debuggingEnabled: false,
                                  onWebViewCreated: (webViewController) {
                                    _controller.complete(webViewController);
                                    webViewController.clearCache();
                                    final cookieManager = CookieManager();
                                    cookieManager.clearCookies();
                                  },
                                  navigationDelegate:
                                      (NavigationRequest request) {
                                    // print("navigationDelegate $request");
                                    // if (request.url.contains('.pdf')) {
                                    //   Utils.launchURL(request.url);
                                    //   return NavigationDecision.prevent;
                                    // }

                                    var checkValue = request.url
                                        .substring(request.url.length - 4);
                                    if (checkValue.contains('+_#D')) {
                                      print("url==${request.url}");
                                      var urldata = request.url;
                                      urldata = urldata.substring(
                                          0, urldata.length - 4);
                                      print("urldata==$urldata");
                                      Utils.launchURL(urldata);
                                      return NavigationDecision.prevent;
                                    }
                                    return NavigationDecision.navigate;
                                  },
                                  onPageStarted: (String url) {
                                    print("onPageStarted $url");
                                    setState(() {
                                      _isLoadingStart = false;
                                      _isLoading = true;
                                    });
                                  },
                                  onPageFinished: (String url) {
                                    print("onPageFinished $url");
                                    if(!_isLoadingStart) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  },
                                  // onPageFinished: (data) {
                                  //   // setState(() {
                                  //   //   isLoading = false;
                                  //   // });
                                  //   webViewScreenBloc.setLoadingStatus(false);
                                  //   print("onPageFinished $data");
                                  // },
                                  // onPageFinished: _handleLoad,
                                  onWebResourceError:
                                      (WebResourceError webviewerrr) async {
                                    print("onWebResourceError");
                                    // webViewScreenBloc.setLoadingStatus(false);
                                    // setState(() {
                                    //   isLoading = false;
                                    // });
                                    // bool isOkay = await showDialog(
                                    //   context: context,
                                    //   barrierDismissible: false,
                                    //   builder: (BuildContext context) {
                                    //     return showDialogForInValid(
                                    //         widget.url, "Invalid QR Code");
                                    //   },
                                    // );
                                    // if (isOkay != null && isOkay) {
                                    //   Navigator.pop(context, true);
                                    // }
                                  },
                                  gestureNavigationEnabled: true,
                                ),
                                _isLoading ? Center(
                                  child: Visibility(
                                      visible: webViewScreenBloc.isLoadingWebview,
                                      child: CustomProgressBar()),
                                ) : Stack(),
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                    /*body: Stack(
                      children: [
                        widget.url.isNotEmpty
                            ? InAppWebView(
                          initialUrlRequest:
                          URLRequest(url: WebUri(widget.url)),
                          initialSettings: settings,
                          onWebViewCreated: (InAppWebViewController aa) {
                            controller = aa;
                          },
                          onLoadStart: (InAppWebViewController controller,
                              Uri? url) async {
                            setState(() {
                              _loading = true;
                            });
                          },
                          shouldOverrideUrlLoading: (controller,
                              shouldOverrideUrlLoadingRequest) async {
                            var url = shouldOverrideUrlLoadingRequest
                                .request.url!
                                .toString();
                            print('==shouldOverrideUrlLoading====$url');
                            // if (url.contains('.pdf')) {
                            //   // _launchURL(url);
                            //   openNewScreen(url);
                            //   return NavigationActionPolicy.CANCEL;
                            // }
                            // return NavigationActionPolicy.ALLOW;

                            // var checkValue = shouldOverrideUrlLoadingRequest
                            //     .request.url
                            //     .toString()
                            //     .substring(shouldOverrideUrlLoadingRequest
                            //     .request.url
                            //     .toString()
                            //     .length -
                            //     4);
                            // if (checkValue.contains('+_#D')) {
                            //   var urldata = shouldOverrideUrlLoadingRequest
                            //       .request.url
                            //       .toString();
                            //   urldata =
                            //       urldata.substring(0, urldata.length - 4);
                            //   print("urldata==$urldata");
                            //   _launchURL(urldata);
                            //   return NavigationActionPolicy.CANCEL;
                            // }
                            return NavigationActionPolicy.ALLOW;
                          },
                          onCloseWindow: (InAppWebViewController controller) {
                            controller.clearCache();
                          },
                          onLoadStop: (InAppWebViewController controller,
                              Uri? url) async {
                            setState(() {
                              _loading = false;
                            });
                          },
                          onProgressChanged: (InAppWebViewController controller,
                              int progress) {},
                          onReceivedError: (controller, request, error) {
                            setState(() {
                              _loading = false;
                            });
                          },
                        )
                            : Container(),
                        Visibility(
                          visible: _loading,
                          child: Center(
                            child: Visibility(
                                visible: webViewScreenBloc.isLoadingWebview,
                                child: CustomProgressBar()),
                          ),
                        ),
                      ],
                    )*/
                  ),
                ),
              ),
            ),
          );
        }));
  }

  Widget showDialogForInValid(String sticker, String message) {
    return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      sticker,
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text(message,
                        style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 25, right: 25, top: 17.5, bottom: 17.5),
                          margin: EdgeInsets.only(top: 25, bottom: 25),
                          decoration: BoxDecoration(
                              color: Color(colorPrimary),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Text(LocaleUtils.getString(context, 'ok'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
