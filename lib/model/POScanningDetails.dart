class POScanningDetails {
  int? fkPOScanningDetailGlCode;
  int? fkZoneGlCode;
  int? fkSubZoneGlCode;
  String? varSticker;
  String? varZoneName;
  String? varSubZoneName;
  String? dtMFGDate;
  bool isExpand = false;
  bool isSubExpand = false;

  POScanningDetails(
      {this.fkPOScanningDetailGlCode,
      this.fkZoneGlCode,
      this.fkSubZoneGlCode,
      this.varSticker,
      this.varZoneName,
      this.varSubZoneName,
      this.dtMFGDate});

  POScanningDetails.fromJson(Map<String, dynamic> json) {
    fkPOScanningDetailGlCode = json['fk_POScanningDetailGlCode'];
    fkZoneGlCode = json['fk_ZoneGlCode'];
    fkSubZoneGlCode = json['fk_SubZoneGlCode'];
    varSticker = json['varSticker'];
    varZoneName = json['varZoneName'];
    varSubZoneName = json['varSubZoneName'];
    dtMFGDate = json['dtMFGDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fk_POScanningDetailGlCode'] = this.fkPOScanningDetailGlCode;
    data['fk_ZoneGlCode'] = this.fkZoneGlCode;
    data['fk_SubZoneGlCode'] = this.fkSubZoneGlCode;
    data['varSticker'] = this.varSticker;
    data['varZoneName'] = this.varZoneName;
    data['varSubZoneName'] = this.varSubZoneName;
    data['dtMFGDate'] = this.dtMFGDate;
    return data;
  }
}
