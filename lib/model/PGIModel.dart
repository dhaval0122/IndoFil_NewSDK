class PGIListModel {
  int? fk_DispatchGlCode;
  String? varGRNumber;
  String? varSoldToName;
  String? varTrucNumber;
  String? dtRequestDate;

  PGIListModel({this.fk_DispatchGlCode, this.varGRNumber, this.varSoldToName, this.varTrucNumber, this.dtRequestDate});

  PGIListModel.fromJson(Map<String, dynamic> json) {
    fk_DispatchGlCode = json['fk_POGlCode'];
    varGRNumber = json['varGRNumber'];
    varSoldToName = json['varSoldToName'];
    varTrucNumber = json['varTrucNumber'];
    dtRequestDate = json['dtRequestDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fk_POGlCode'] = this.fk_DispatchGlCode;
    data['varGRNumber'] = this.varGRNumber;
    data['varSoldToName'] = this.varSoldToName;
    data['varTrucNumber'] = this.varTrucNumber;
    data['dtRequestDate'] = this.dtRequestDate;
    return data;
  }
}