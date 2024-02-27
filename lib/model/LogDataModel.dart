class LogdataModel {
  String? fk_MenuGlCode;
  String? dtPageIn;
  String? dtPageOut;
  String? fk_PersonGlCode;
  String? varSubModuleName;
  String? varSystemName;
  String? varVersion;
  String? varFormName;
  String? fk_LDGLCode;

  LogdataModel(
      {this.fk_MenuGlCode,
      this.dtPageIn,
      this.dtPageOut,
      this.fk_PersonGlCode,
      this.varSubModuleName,
      this.varSystemName,
      this.varVersion,
      this.varFormName,
      this.fk_LDGLCode});

  factory LogdataModel.fromJson(Map<String, dynamic> json) {
    return LogdataModel(
        fk_MenuGlCode:
            json.containsKey("fk_MenuGlCode") ? json['fk_MenuGlCode'] : 0 as String?,
        dtPageIn: json.containsKey("dtPageIn") ? json['dtPageIn'] : "",
        dtPageOut: json.containsKey("dtPageOut") ? json['dtPageOut'] : "",
        fk_PersonGlCode:
            json.containsKey("fk_PersonGlCode") ? json['fk_PersonGlCode'] : "",
        varSubModuleName: json.containsKey("varSubModuleName")
            ? json['varSubModuleName']
            : "",
        varSystemName:
            json.containsKey("varSystemName") ? json['varSystemName'] : "",
        varVersion: json.containsKey("varVersion") ? json['varVersion'] : "",
        varFormName: json.containsKey("varFormName") ? json['varFormName'] : "",
        fk_LDGLCode:
            json.containsKey("fk_LDGLCode") ? json['fk_LDGLCode'] : "");
  }

  Map<String, dynamic> toJson() => {
        'fk_MenuGlCode': this.fk_MenuGlCode,
        'dtPageIn': this.dtPageIn,
        'dtPageOut': this.dtPageOut,
        'fk_PersonGlCode': this.fk_PersonGlCode,
        'varSubModuleName': this.varSubModuleName,
        'varSystemName': this.varSystemName,
        'varVersion': this.varVersion,
        'varFormName': this.varFormName,
        'fk_LDGLCode': this.fk_LDGLCode,
      };
}
