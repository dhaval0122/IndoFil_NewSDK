class ProductDetails {
  String? fk_PRDGlCode = '';
  String? fk_PBGGlCOde = '';
  String? varPRDCode = '';
  String? varPRDName = '';

  ProductDetails(
      {this.fk_PRDGlCode, this.fk_PBGGlCOde, this.varPRDCode, this.varPRDName});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    fk_PRDGlCode = '${json['fk_PRDGlCode']}';
    fk_PBGGlCOde = '${json['fk_PBGGlCOde']}';
    varPRDCode = json['varPRDCode'];
    varPRDName = json['varPRDName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fk_PRDGlCode'] = this.fk_PRDGlCode;
//    data['fk_PBGGlCOde'] = this.fk_PBGGlCOde;
//    data['varPRDCode'] = this.varPRDCode;
//    data['varPRDName'] = this.varPRDName;
    return data;
  }
}

class CropDetails {
  String? fk_CROPGlCode;
  String? varCropCode;
  String? varCropName;
  String? varCropDescription = '';
  String? land_size;

  CropDetails(
      {this.fk_CROPGlCode,
      this.varCropCode,
      this.varCropName,
      this.varCropDescription});

  CropDetails.fromJson(Map<String, dynamic> json) {
    fk_CROPGlCode = '${json['fk_CROPGlCode']}';
    varCropCode = json['varCropCode'];
    varCropName = json['varCropName'];
    varCropDescription = json['varCropDescription'];
    land_size = '${json['decLandSize']}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fk_CropGlCode'] = this.fk_CROPGlCode;
//    data['varCropCode'] = this.varCropCode;
//    data['varCropName'] = this.varCropName;
//    data['varCropDescription'] = this.varCropDescription;
    data['decLandSize'] = this.land_size;
    return data;
  }
}

class GeoLabel {
  String? levelName;
  String? levelId;

  GeoLabel({this.levelName, this.levelId});

  GeoLabel.fromJson(Map<String, dynamic> json) {
    levelName = json['level_name'];
    levelId = json['level_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['level_name'] = this.levelName;
    data['level_id'] = this.levelId;
    return data;
  }
}

class GeoData {
  String? fk_PoliticalGeoGlCode;
  String? varPolitical_Geography_Name;
  String? varPolitical_Geography_Code;

  GeoData({this.fk_PoliticalGeoGlCode, this.varPolitical_Geography_Name});

  GeoData.fromJson(Map<String, dynamic> json) {
    fk_PoliticalGeoGlCode = '${json['fk_PoliticalGeoGlCode']}';
    varPolitical_Geography_Name = json['varPolitical_Geography_Name'];
    varPolitical_Geography_Code = json['varPolitical_Geography_Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fk_PoliticalGeoGlCode'] = this.fk_PoliticalGeoGlCode;
    data['varPolitical_Geography_Name'] = this.varPolitical_Geography_Name;
    return data;
  }
}
