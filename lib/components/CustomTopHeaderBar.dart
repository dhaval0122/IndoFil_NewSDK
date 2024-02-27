import 'package:flutter/material.dart';
import 'package:flutter_basf_hk_app/styles/colors.dart';

class CustomTopHeaderBar extends StatelessWidget {
  final String userName;
  final String lastSyncDate;
  final String imagePath;

  CustomTopHeaderBar(this.userName, this.lastSyncDate, this.imagePath);

  @override
  Widget build(BuildContext context) {
    List<Widget> _actionButton() {
      return <Widget>[
        imagePath.isNotEmpty
            ? Image.asset(
                imagePath,
                height: 20,
                width: 20,
                color: Color(colorPrimary),
              )
            : Container(),
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(lastSyncDate != null ? lastSyncDate : "",
              style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  color: Colors.black)),
        )
      ];
    }

    return Container(
      color: Color(colorAccent),
      padding: EdgeInsets.only(top: 7, bottom: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(userName != null ? userName : "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
            ),
          ),
          Container(
              child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: _actionButton()))),
        ],
      ),
    );
  }
}
