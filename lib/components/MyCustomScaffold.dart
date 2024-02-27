import 'package:flutter/material.dart';

class MyCustomScaffold extends Scaffold {
  MyCustomScaffold({
    AppBar? appBar,
    Widget? body,
    required GlobalKey<ScaffoldState> key,
    Widget? floatingActionButton,
    FloatingActionButtonLocation? floatingActionButtonLocation,
    FloatingActionButtonAnimator? floatingActionButtonAnimator,
    List<Widget>? persistentFooterButtons,
    Widget? drawer,
    Widget? endDrawer,
    Widget? bottomNavigationBar,
    Widget? bottomSheet,
    Color? backgroundColor,
    bool resizeToAvoidBottomPadding = true,
    bool primary = true,
  })  : assert(key != null),
        super(
          key: key,
          appBar: endDrawer != null &&
                  appBar!.actions != null &&
                  appBar.actions!.isNotEmpty
              ? _buildEndDrawerButton(appBar, key)
              : appBar,
          body: body,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
          floatingActionButtonAnimator: floatingActionButtonAnimator,
          persistentFooterButtons: persistentFooterButtons,
          drawer: drawer,
          endDrawer: endDrawer,
          bottomNavigationBar: bottomNavigationBar,
          bottomSheet: bottomSheet,
          backgroundColor: backgroundColor,
          resizeToAvoidBottomInset: resizeToAvoidBottomPadding,
          primary: primary,
        );

  static AppBar _buildEndDrawerButton(
      AppBar myAppBar, GlobalKey<ScaffoldState> _keyScaffold) {
    myAppBar.actions!.add(IconButton(
        icon: Icon(Icons.menu),
        onPressed: () => !_keyScaffold.currentState!.isEndDrawerOpen
            ? _keyScaffold.currentState!.openEndDrawer()
            : null));
    return myAppBar;
  }
}
