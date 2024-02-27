import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basf_hk_app/localization/LocaleUtils.dart';

// ignore: must_be_immutable
class SearchableSpinner extends StatefulWidget {
  List<SpinnerModel>? list = [];
  String? hintText = "";
  ItemClickSearchableSpinner? itemClickSearchableSpinner;

  SearchableSpinner(
      {this.list, this.itemClickSearchableSpinner, this.hintText});

  @override
  SearchableSpinnerState createState() => SearchableSpinnerState();
}

class SearchableSpinnerState extends State<SearchableSpinner> {
  TextEditingController controller = TextEditingController();
  String? filter;
  bool noDataInSearch = false;

  @override
  void initState() {
    super.initState();
    //fill countries with objects
    controller.addListener(() {
      setState(() {
        filter = controller.text;
        for (SpinnerModel data in widget.list!) {
          if (data.name.toLowerCase().contains(filter!.toLowerCase())) {
            noDataInSearch = false;
            break;
          } else {
            noDataInSearch = true;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return AlertDialog(
        contentPadding: const EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5.0))),
        //title:  Text('Alert Dialog title'),
        content: Container(
            width: width * 0.9,
            height: height * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                    padding:
                        EdgeInsets.only(top: 15.0, left: 16.0, right: 16.0),
                    child: Text(LocaleUtils.getString(context, 'Search_'),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto',
                          color: Colors.black,
                        ))),
                Padding(
                    padding: EdgeInsets.only(top: 2.0, left: 16.0, right: 16.0),
                    child: TextField(
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          hintText: widget.hintText != null &&
                                  widget.hintText!.length > 0
                              ? widget.hintText
                              : LocaleUtils.getString(
                                  context, 'what_are_you_looking_for'),
                          hintStyle: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            // fontFamily: 'Roboto',
                            color: Colors.black87,
                          )),
                      controller: controller,
                    )),
                Expanded(
                    child: widget.list!.isNotEmpty && !noDataInSearch
                        ? Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: _buildListView())
                        : _noResFound()),
              ],
            )));
  }

  Widget _buildListView() {
    return Scrollbar(
        child: ListView.builder(
            itemCount: widget.list!.length,
            itemBuilder: (BuildContext context, int index) {
              if (filter == null || filter == "") {
                return _buildRow(widget.list![index]);
              } else {
                if (widget.list![index].name
                    .toLowerCase()
                    .contains(filter!.toLowerCase())) {
                  return _buildRow(widget.list![index]);
                } else {
                  return Container();
                }
              }
            }));
  }

  Widget _buildRow(SpinnerModel data) {
    return ListTile(
      title: Text(
        data.name,
      ),
      onTap: () {
        widget.itemClickSearchableSpinner!.onItemClickSearchableSpinner(data);
        Navigator.of(context).pop();
      },
    );
  }

  Widget _noResFound() {
    return Center(
      child: Text(LocaleUtils.getString(context, 'NoDataFound'),
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
            color: Colors.black87,
          )),
    );
  }
}

abstract class ItemClickSearchableSpinner {
  void onItemClickSearchableSpinner(SpinnerModel model);
}

class SpinnerModel {
  String intGlCode;
  String name;
  String? cid;
  int spinnerID;

  SpinnerModel(this.intGlCode, this.name, this.spinnerID, {this.cid});
}

class SpinnerLangModel {
  String intGlCode;
  String langName;
  String name;
  int spinnerID;

  SpinnerLangModel(this.intGlCode, this.langName, this.name, this.spinnerID);
}
