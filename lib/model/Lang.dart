class LanguageDetails {
  int? fkLanguageGlCode;
  String? varLanguageCode;
  String? varLanguageName;
  String? chrDefault;

  LanguageDetails(
      {this.fkLanguageGlCode,
      this.varLanguageCode,
      this.varLanguageName,
      this.chrDefault});

  LanguageDetails.fromJson(Map<String, dynamic> json) {
    fkLanguageGlCode = json['fk_LanguageGlCode'];
    varLanguageCode = json['varLanguageCode'];
    varLanguageName = json['varLanguageName'];
    chrDefault = json['chrDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fk_LanguageGlCode'] = this.fkLanguageGlCode;
    data['varLanguageCode'] = this.varLanguageCode;
    data['varLanguageName'] = this.varLanguageName;
    data['chrDefault'] = this.chrDefault;
    return data;
  }
}

class DefaultLanguageDetails {
  int? fkLanguageGlCode;

  DefaultLanguageDetails({this.fkLanguageGlCode});

  DefaultLanguageDetails.fromJson(Map<String, dynamic> json) {
    fkLanguageGlCode = json['fk_LanguageGlCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fk_LanguageGlCode'] = this.fkLanguageGlCode;
    return data;
  }
}
