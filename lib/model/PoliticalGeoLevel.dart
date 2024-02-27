class PoliticalGeoLevel {
  String? fkPoliticalGeoLevelCountryGlCode;
  String? fkPoliticalGeoLevelRegionalGlCode;
  String? varLevel;
  String? varGeoLevelName;
  String? chrDefault;

  PoliticalGeoLevel(
      {this.fkPoliticalGeoLevelCountryGlCode,
      this.fkPoliticalGeoLevelRegionalGlCode,
      this.varLevel,
      this.varGeoLevelName,
      this.chrDefault});

  PoliticalGeoLevel.fromJson(Map<String, dynamic> json) {
    fkPoliticalGeoLevelCountryGlCode =
        '${json['fk_Political_Geo_Level_CountryGlCode']}';
    fkPoliticalGeoLevelRegionalGlCode =
        '${json['fk_Political_Geo_Level_RegionalGlCode']}';
    varLevel = json['varLevel'];
    varGeoLevelName = json['varGeo_Level_Name'];
    chrDefault = json['chrDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fk_Political_Geo_Level_CountryGlCode'] =
        this.fkPoliticalGeoLevelCountryGlCode;
    data['fk_Political_Geo_Level_RegionalGlCode'] =
        this.fkPoliticalGeoLevelRegionalGlCode;
    data['varLevel'] = this.varLevel;
    data['varGeo_Level_Name'] = this.varGeoLevelName;
    data['chrDefault'] = this.chrDefault;
    return data;
  }
}
