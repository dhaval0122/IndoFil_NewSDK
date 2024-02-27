class NotificationModel {
  int? intCount;
  int? fk_NotificationGlCode;
  int? fk_GlCode;
  String? dtDate;
  String? varNotification_Code;
  String? varSubject;
  String? varMessage;
  String? chrRead;
  String? chrColor;
  String? chrSync;

  NotificationModel({
    this.intCount,
    this.fk_NotificationGlCode,
    this.fk_GlCode,
    this.dtDate,
    this.varNotification_Code,
    this.varSubject,
    this.varMessage,
    this.chrRead,
    this.chrColor,
    this.chrSync,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      intCount: json.containsKey('intCount') ? json['intCount'] : 0,
      fk_NotificationGlCode: json.containsKey('fk_NotificationGlCode')
          ? json['fk_NotificationGlCode']
          : 0,
      fk_GlCode: json.containsKey('fk_GlCode') ? json['fk_GlCode'] : 0,
      dtDate: json.containsKey('dtDate') ? json['dtDate'] : "",
      varNotification_Code: json.containsKey('varNotification_Code')
          ? json['varNotification_Code']
          : "",
      varSubject: json.containsKey('varSubject') ? json['varSubject'] : "",
      varMessage: json.containsKey('varMessage') ? json['varMessage'] : "",
      chrRead: json.containsKey('chrRead') ? json['chrRead'] : "",
      chrColor: json.containsKey('chrColor') ? json['chrColor'] : "",
      chrSync: json.containsKey('chrSync') ? json['chrSync'] : "",
    );
  }

  NotificationModel.fromMap(Map<String, dynamic> json) {
    this.intCount = json.containsKey('intCount') ? json['intCount'] : 0;
    this.fk_NotificationGlCode = json.containsKey('fk_NotificationGlCode')
        ? json['fk_NotificationGlCode']
        : 0;
    this.fk_GlCode = json.containsKey('fk_GlCode') ? json['fk_GlCode'] : 0;
    this.dtDate = json.containsKey('dtDate') ? json['dtDate'] : "";
    this.varNotification_Code = json.containsKey('varNotification_Code')
        ? json['varNotification_Code']
        : "";
    this.varSubject = json.containsKey('varSubject') ? json['varSubject'] : "";
    this.varMessage = json.containsKey('varMessage') ? json['varMessage'] : "";
    this.chrRead = json.containsKey('chrRead') ? json['chrRead'] : "";
    this.chrColor = json.containsKey('chrColor') ? json['chrColor'] : "";
    this.chrSync = json.containsKey('chrSync') ? json['chrSync'] : "";
  }
}

class NotificationNewModel {
  int? intCount;
  int? fk_NotificationGlCode;
  int? fk_GlCode;
  String? dtDate;
  String? varNotification_Code;
  String? varSubject;
  String? varMessage;
  String? chrRead;
  String? chrColor;
  String? chrSync;

  NotificationNewModel({
    this.intCount,
    this.fk_NotificationGlCode,
    this.fk_GlCode,
    this.dtDate,
    this.varNotification_Code,
    this.varSubject,
    this.varMessage,
    this.chrRead,
    this.chrColor,
    this.chrSync,
  });

  factory NotificationNewModel.fromJson(Map<String, dynamic> json) {
    return NotificationNewModel(
      intCount: json.containsKey('intCount') ? json['intCount'] : 0,
      fk_NotificationGlCode: json.containsKey('fk_NotificationGlCode')
          ? json['fk_NotificationGlCode']
          : 0,
      fk_GlCode: json.containsKey('fk_GlCode') ? json['fk_GlCode'] : 0,
      dtDate: json.containsKey('dtDate') ? json['dtDate'] : "",
      varNotification_Code: json.containsKey('varNotification_Code')
          ? json['varNotification_Code']
          : "",
      varSubject: json.containsKey('varSubject') ? json['varSubject'] : "",
      varMessage: json.containsKey('varMessage') ? json['varMessage'] : "",
      chrRead: json.containsKey('chrRead') ? json['chrRead'] : "",
      chrColor: json.containsKey('chrColor') ? json['chrColor'] : "",
      chrSync: json.containsKey('chrSync') ? json['chrSync'] : "",
    );
  }

  NotificationNewModel.fromMap(Map<String, dynamic> json) {
    this.intCount = json.containsKey('intCount') ? json['intCount'] : 0;
    this.fk_NotificationGlCode = json.containsKey('fk_NotificationGlCode')
        ? json['fk_NotificationGlCode']
        : 0;
    this.fk_GlCode = json.containsKey('fk_GlCode') ? json['fk_GlCode'] : 0;
    this.dtDate = json.containsKey('dtDate') ? json['dtDate'] : "";
    this.varNotification_Code = json.containsKey('varNotification_Code')
        ? json['varNotification_Code']
        : "";
    this.varSubject = json.containsKey('varSubject') ? json['varSubject'] : "";
    this.varMessage = json.containsKey('varMessage') ? json['varMessage'] : "";
    this.chrRead = json.containsKey('chrRead') ? json['chrRead'] : "";
    this.chrColor = json.containsKey('chrColor') ? json['chrColor'] : "";
    this.chrSync = json.containsKey('chrSync') ? json['chrSync'] : "";
  }
}

class GRListModel {
  int? fkPOGlCode;
  String? varGRNumber;
  String? dtRequestDate;

  GRListModel({this.fkPOGlCode, this.varGRNumber, this.dtRequestDate});

  GRListModel.fromJson(Map<String, dynamic> json) {
    fkPOGlCode = json['fk_POGlCode'];
    varGRNumber = json['varGRNumber'];
    dtRequestDate = json['dtRequestDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fk_POGlCode'] = this.fkPOGlCode;
    data['varGRNumber'] = this.varGRNumber;
    data['dtRequestDate'] = this.dtRequestDate;
    return data;
  }
}

class GRProductListModel {
  int? fkPOGlCode;
  int? fkPODetailGlCode;
  String? varPorductSKUCode;
  String? varProductSKUName;
  String? varUOMName;
  int? intQuantity;
  int? intScanningQty;
  int? intPendingQty;
  String? chrColorCode;

  GRProductListModel(
      {this.fkPOGlCode,
      this.fkPODetailGlCode,
      this.varPorductSKUCode,
      this.varProductSKUName,
      this.varUOMName,
      this.intQuantity,
      this.intScanningQty,
      this.intPendingQty,
      this.chrColorCode});

  GRProductListModel.fromJson(Map<String, dynamic> json) {
    fkPOGlCode = json['fk_POGlCode'];
    fkPODetailGlCode = json['fk_PODetailGlCode'];
    varPorductSKUCode = json['varPorduct_SKU_Code'];
    varProductSKUName = json['varProduct_SKU_Name'];
    varUOMName = json['varUOM_Name'];
    intQuantity = json['intQuantity'];
    intScanningQty = json['intScanningQty'];
    intPendingQty = json['intPendingQty'];
    chrColorCode = json['chrColorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fk_POGlCode'] = this.fkPOGlCode;
    data['fk_PODetailGlCode'] = this.fkPODetailGlCode;
    data['varPorduct_SKU_Code'] = this.varPorductSKUCode;
    data['varProduct_SKU_Name'] = this.varProductSKUName;
    data['varUOM_Name'] = this.varUOMName;
    data['intQuantity'] = this.intQuantity;
    data['intScanningQty'] = this.intScanningQty;
    data['intPendingQty'] = this.intPendingQty;
    data['chrColorCode'] = this.chrColorCode;
    return data;
  }
}

class SubZoneModel {
  int? fkZoneGlCode;
  int? fkSubZoneGlCode;
  String? varZoneName;
  String? varSubZoneName;

  SubZoneModel(
      {this.fkZoneGlCode,
      this.fkSubZoneGlCode,
      this.varZoneName,
      this.varSubZoneName});

  SubZoneModel.fromJson(Map<String, dynamic> json) {
    fkZoneGlCode =
        json.containsKey('fk_ZoneGlCode') ? json['fk_ZoneGlCode'] : 0;
    fkSubZoneGlCode = json['fk_SubZoneGlCode'];
    varZoneName = json.containsKey('varZoneName') ? json['varZoneName'] : '';
    varSubZoneName = json['varSubZoneName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fk_ZoneGlCode'] = this.fkZoneGlCode;
    data['fk_SubZoneGlCode'] = this.fkSubZoneGlCode;
    data['varZoneName'] = this.varZoneName;
    data['varSubZoneName'] = this.varSubZoneName;
    return data;
  }
}

class ScanningSummaryModel {
  int? intTotalQty;
  int? intScannedQty;
  int? intPendingQty;

  ScanningSummaryModel(
      {this.intTotalQty, this.intScannedQty, this.intPendingQty});

  ScanningSummaryModel.fromJson(Map<String, dynamic> json) {
    intTotalQty = json['intTotalQty'];
    intScannedQty = json['intScannedQty'];
    intPendingQty = json['intPendingQty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['intTotalQty'] = this.intTotalQty;
    data['intScannedQty'] = this.intScannedQty;
    data['intPendingQty'] = this.intPendingQty;
    return data;
  }
}