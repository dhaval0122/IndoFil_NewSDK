class EarnPoint {
  double? decEarnPoint;

  EarnPoint({this.decEarnPoint});

  EarnPoint.fromJson(Map<String, dynamic> json) {
    print("decEarnPoint---" + json['decEarnPoint'].toString());

    if (json['decEarnPoint'] != null) {
      decEarnPoint = json['decEarnPoint'];
    } else {
      decEarnPoint = 0.0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['decEarnPoint'] = this.decEarnPoint;
    return data;
  }
}

class EarningSummary {
  String? varSchemeName;
  String? varEarnFrom;
  String? dtSchemePoint;
  double? decEarnPoint;

  EarningSummary(
      {this.varSchemeName,
      this.varEarnFrom,
      this.dtSchemePoint,
      this.decEarnPoint});

  EarningSummary.fromJson(Map<String, dynamic> json) {
    varSchemeName = json['varSchemeName'];
    varEarnFrom = json['varEarnFrom'];
    dtSchemePoint = json['dtSchemePoint'];
    decEarnPoint = json['decEarnPoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['varSchemeName'] = this.varSchemeName;
    data['varEarnFrom'] = this.varEarnFrom;
    data['dtSchemePoint'] = this.dtSchemePoint;
    data['decEarnPoint'] = this.decEarnPoint;
    return data;
  }
}
