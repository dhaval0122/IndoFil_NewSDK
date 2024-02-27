class LoginResModel {
  String? userId;
  String? displayName;
  String? firmName;
  String? firstName;
  String? lastName;
  String? email;
  String? primaryMobileNo;
  String? secondaryMobileNo;
  String? landlineNo;
  String? color;
  String? colorCodeDark;
  String? colorCodeLight;
  String? language;
  String? roleId;
  String? roleCode;
  String? bussinescode;
  String? countryId;
  String? localDate;
  String? type;
  String? authKey;
  int? loginId;
  String? licenseNo;
  int? licenseCountryConfig;
  String? termsCondition;
  String? ftpUsername;
  String? ftpPassword;
  String? ftpPort;
  String? ftpHost;
  String? isSyncPopUp;
  String? scanMsg;
  String? parentUserId;
  String? varhotlinetext;
  String? varhotlinelabel;
  String? customerLevel;
  String? customerGeoLevel;
  String? customerGeoLevel4;
  String? customerGeoLevel5;
  int? isCheckLoginFirst;
  int? scanlimit;
  String? showRetailerTab;
  String? CustomertTypeNameRet;
  String? customertypecountryid;
  String? points;

  LoginResModel(
      {this.userId,
      this.displayName,
      this.firmName,
      this.firstName,
      this.lastName,
      this.email,
      this.primaryMobileNo,
      this.secondaryMobileNo,
      this.landlineNo,
      this.color,
      this.colorCodeDark,
      this.colorCodeLight,
      this.language,
      this.roleId,
      this.roleCode,
      this.bussinescode,
      this.countryId,
      this.localDate,
      this.type,
      this.authKey,
      this.loginId,
      this.licenseNo,
      this.licenseCountryConfig,
      this.termsCondition,
      this.ftpUsername,
      this.ftpPassword,
      this.ftpPort,
      this.ftpHost,
      this.isSyncPopUp,
      this.scanMsg,
      this.parentUserId,
      this.varhotlinetext,
      this.varhotlinelabel,
      this.customerLevel,
      this.customerGeoLevel,
      this.customerGeoLevel4,
      this.customerGeoLevel5,
      this.isCheckLoginFirst,
      this.scanlimit,
      this.showRetailerTab,
      this.CustomertTypeNameRet,
      this.customertypecountryid,
      this.points});

  LoginResModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    displayName = json['display_name'];
    firmName = json['firm_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    primaryMobileNo = json['primary_mobile_no'];
    secondaryMobileNo = json['secondary_mobile_no'];
    landlineNo = json['landline_no'];
    color = json['color'];
    colorCodeDark = json['color_code_dark'];
    colorCodeLight = json['color_code_light'];
    language = json['language'];
    roleId = json['role_id'];
    roleCode = json['role_code'];
    bussinescode = json['bussinescode'];
    countryId = json['country_id'];
    localDate = json['local_date'];
    type = json['type'];
    authKey = json['auth_key'];
    loginId = json['login_id'];
    licenseNo = json['license_no'];
    licenseCountryConfig = json['licenseCountryConfig'];
    termsCondition = json['terms_condition'];
    ftpUsername = json['ftp_username'];
    ftpPassword = json['ftp_password'];
    ftpPort = json['ftp_port'];
    ftpHost = json['ftp_host'];
    isSyncPopUp = json['is_Sync_PopUp'];
    scanMsg = json['scan_msg'];
    parentUserId = json['parent_user_id'];
    varhotlinetext = json['varhotlinetext'];
    varhotlinelabel = json['varhotlinelabel'];
    customerLevel = json['customer_level'];
    customerGeoLevel = json['customer_geo_level'];
    customerGeoLevel4 = json['customer_geo_level4'];
    customerGeoLevel5 = json['customer_geo_level5'];
    isCheckLoginFirst = json['isCheckLoginFirst'];
    scanlimit = json['Scanlimit'];
    showRetailerTab = json['ShowRetailerTab'];
    CustomertTypeNameRet = json['CustomertTypeNameRet'];
    customertypecountryid = json['customerTypeCountryId'];
    points = json.containsKey('points') ? json['points'] : '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['display_name'] = this.displayName;
    data['firm_name'] = this.firmName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['primary_mobile_no'] = this.primaryMobileNo;
    data['secondary_mobile_no'] = this.secondaryMobileNo;
    data['landline_no'] = this.landlineNo;
    data['color'] = this.color;
    data['color_code_dark'] = this.colorCodeDark;
    data['color_code_light'] = this.colorCodeLight;
    data['language'] = this.language;
    data['role_id'] = this.roleId;
    data['role_code'] = this.roleCode;
    data['bussinescode'] = this.bussinescode;
    data['country_id'] = this.countryId;
    data['local_date'] = this.localDate;
    data['type'] = this.type;
    data['auth_key'] = this.authKey;
    data['login_id'] = this.loginId;
    data['license_no'] = this.licenseNo;
    data['licenseCountryConfig'] = this.licenseCountryConfig;
    data['terms_condition'] = this.termsCondition;
    data['ftp_username'] = this.ftpUsername;
    data['ftp_password'] = this.ftpPassword;
    data['ftp_port'] = this.ftpPort;
    data['ftp_host'] = this.ftpHost;
    data['is_Sync_PopUp'] = this.isSyncPopUp;
    data['scan_msg'] = this.scanMsg;
    data['parent_user_id'] = this.parentUserId;
    data['varhotlinetext'] = this.varhotlinetext;
    data['varhotlinelabel'] = this.varhotlinelabel;
    data['customer_level'] = this.customerLevel;
    data['customer_geo_level'] = this.customerGeoLevel;
    data['customer_geo_level4'] = this.customerGeoLevel4;
    data['customer_geo_level5'] = this.customerGeoLevel5;
    data['isCheckLoginFirst'] = this.isCheckLoginFirst;
    data['Scanlimit'] = this.scanlimit;
    data['ShowRetailerTab'] = this.showRetailerTab;
    data['CustomertTypeNameRet'] = this.CustomertTypeNameRet;
    data['customerTypeCountryId'] = this.customertypecountryid;
    data['points'] = this.points;
    return data;
  }
}

class PersonMst {
  int? intGlCode;
  String? chrUserType;
  int? fkCountryGlCode;
  String? varUserID;
  String? varPassword;
  String? varSAPCode;
  String? varFirstName;
  String? varMiddleName;
  String? varLastName;
  String? varAddress;
  String? varEmail;
  String? chrUserLock;
  String? varPhoneNo;
  String? varMobileNo;
  String? varFullName;
  String? varOrganisationName;
  int? fkCustomerTypeCountryGlCode;
  int? fkEmployeeTypeGlCode;
  int? fkEmployeeDesignationCountryGlCode;
  int? fkPoliticalGeoGlCode;
  int? fkLanguageGlCode;
  String? varLanguageCode;
  String? chrActive;
  String? dtEntryDate;
  int? refEntryBy;
  String? dtModifiedDate;
  int? refModifiedBy;
  String? dtValidFrom;
  String? dtValidTo;
  String? varPrintingCode;
  int? refParentGlCode;
  String? varAPIToken;
  String? varServerName;
  String? chrCPM;
  String? chrICM;
  String? chrAgree;
  String? varAgreementUrl;
  String? chrStep2Registration;
  String? varAddress1;
  String? varPincode;
  int? fkL3PoliticalGeoGlCode;
  int? fkL2PoliticalGeoGlCode;
  int? fkL1PoliticalGeoGlCode;
  String? varReferralCode;
  String? varlatitude;
  String? varlongitude;
  String? strDateFormatMSSQL;
  String? strTimeFormatMSSQL;
  String? strDateTimeFormatMSSQL;
  String? strDateFormatSQLLite;
  String? strTimeFormatSQLLite;
  String? strDateTimeFormatSQLLite;
  String? varSyncCode;
  String? dtSyncDate;
  String? chrGender;
  String? varImageURL;

  PersonMst(
      {this.intGlCode,
      this.chrUserType,
      this.fkCountryGlCode,
      this.varUserID,
      this.varPassword,
      this.varSAPCode,
      this.varFirstName,
      this.varMiddleName,
      this.varLastName,
      this.varAddress,
      this.varEmail,
      this.chrUserLock,
      this.varPhoneNo,
      this.varMobileNo,
      this.varFullName,
      this.varOrganisationName,
      this.fkCustomerTypeCountryGlCode,
      this.fkEmployeeTypeGlCode,
      this.fkEmployeeDesignationCountryGlCode,
      this.fkPoliticalGeoGlCode,
      this.fkLanguageGlCode,
      this.varLanguageCode,
      this.chrActive,
      this.dtEntryDate,
      this.refEntryBy,
      this.dtModifiedDate,
      this.refModifiedBy,
      this.dtValidFrom,
      this.dtValidTo,
      this.varPrintingCode,
      this.refParentGlCode,
      this.varAPIToken,
      this.varServerName,
      this.chrCPM,
      this.chrICM,
      this.chrAgree,
      this.varAgreementUrl,
      this.chrStep2Registration,
      this.varAddress1,
      this.varPincode,
      this.fkL3PoliticalGeoGlCode,
      this.fkL2PoliticalGeoGlCode,
      this.fkL1PoliticalGeoGlCode,
      this.varReferralCode,
      this.varlatitude,
      this.varlongitude,
      this.strDateFormatMSSQL,
      this.strTimeFormatMSSQL,
      this.strDateTimeFormatMSSQL,
      this.strDateFormatSQLLite,
      this.strTimeFormatSQLLite,
      this.strDateTimeFormatSQLLite,
      this.varSyncCode,
      this.dtSyncDate,
      this.chrGender,
      this.varImageURL});

  PersonMst.fromJson(Map<String, dynamic> json) {
    intGlCode = json['intGlCode'];
    chrUserType = json['chrUserType'];
    fkCountryGlCode = json['fk_CountryGlCode'];
    varUserID = json['varUserID'];
    varPassword = json['varPassword'];
    varSAPCode = json['varSAPCode'];
    varFirstName = json['varFirstName'];
    varMiddleName = json['varMiddleName'];
    varLastName = json['varLastName'];
    varAddress = json['varAddress'];
    varEmail = json['varEmail'];
    chrUserLock = json['chrUserLock'];
    varPhoneNo = json['varPhoneNo'];
    varMobileNo = json['varMobileNo'];
    varFullName = json['varFullName'];
    varOrganisationName = json['varOrganisationName'];
    fkCustomerTypeCountryGlCode = json['fk_Customer_Type_CountryGlCode'];
    fkEmployeeTypeGlCode = json['fk_Employee_TypeGlCode'];
    fkEmployeeDesignationCountryGlCode =
        json['fk_Employee_Designation_CountryGlCode'];
    fkPoliticalGeoGlCode = json['fk_Political_GeoGlCode'];
    fkLanguageGlCode = json['fk_LanguageGlCode'];
    varLanguageCode = json['varLanguageCode'];
    chrActive = json['chrActive'];
    dtEntryDate = json['dtEntryDate'];
    refEntryBy = json['ref_Entry_By'];
    dtModifiedDate = json['dtModifiedDate'];
    refModifiedBy = json['ref_Modified_By'];
    dtValidFrom = json['dtValidFrom'];
    dtValidTo = json['dtValidTo'];
    varPrintingCode = json['varPrintingCode'];
    refParentGlCode = json['refParentGlCode'];
    varAPIToken = json['varAPIToken'];
    varServerName = json['varServerName'];
    chrCPM = json['chrCPM'];
    chrICM = json['chrICM'];
    chrAgree = json['chrAgree'];
    varAgreementUrl = json['varAgreementUrl'];
    chrStep2Registration = json['chrStep2Registration'];
    varAddress1 = json['varAddress1'];
    varPincode = json['varPincode'];
    fkL3PoliticalGeoGlCode = json['fk_L3_PoliticalGeoGlCode'];
    fkL2PoliticalGeoGlCode = json['fk_L2_PoliticalGeoGlCode'];
    fkL1PoliticalGeoGlCode = json['fk_L1_PoliticalGeoGlCode'];
    varReferralCode = json['varReferralCode'];
    varlatitude = json['varlatitude'];
    varlongitude = json['varlongitude'];
    strDateFormatMSSQL = json['strDateFormat_MSSQL'];
    strTimeFormatMSSQL = json['strTimeFormat_MSSQL'];
    strDateTimeFormatMSSQL = json['strDateTimeFormat_MSSQL'];
    strDateFormatSQLLite = json['strDateFormat_SQLLite'];
    strTimeFormatSQLLite = json['strTimeFormat_SQLLite'];
    strDateTimeFormatSQLLite = json['strDateTimeFormat_SQLLite'];
    varSyncCode = json['varSync_Code'];
    dtSyncDate = json['dtSyncDate'];
    chrGender = json['chrGender'];
    varImageURL = json['varImageURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intGlCode'] = this.intGlCode;
    data['chrUserType'] = this.chrUserType;
    data['fk_CountryGlCode'] = this.fkCountryGlCode;
    data['varUserID'] = this.varUserID;
    data['varPassword'] = this.varPassword;
    data['varSAPCode'] = this.varSAPCode;
    data['varFirstName'] = this.varFirstName;
    data['varMiddleName'] = this.varMiddleName;
    data['varLastName'] = this.varLastName;
    data['varAddress'] = this.varAddress;
    data['varEmail'] = this.varEmail;
    data['chrUserLock'] = this.chrUserLock;
    data['varPhoneNo'] = this.varPhoneNo;
    data['varMobileNo'] = this.varMobileNo;
    data['varFullName'] = this.varFullName;
    data['varOrganisationName'] = this.varOrganisationName;
    data['fk_Customer_Type_CountryGlCode'] = this.fkCustomerTypeCountryGlCode;
    data['fk_Employee_TypeGlCode'] = this.fkEmployeeTypeGlCode;
    data['fk_Employee_Designation_CountryGlCode'] =
        this.fkEmployeeDesignationCountryGlCode;
    data['fk_Political_GeoGlCode'] = this.fkPoliticalGeoGlCode;
    data['fk_LanguageGlCode'] = this.fkLanguageGlCode;
    data['varLanguageCode'] = this.varLanguageCode;
    data['chrActive'] = this.chrActive;
    data['dtEntryDate'] = this.dtEntryDate;
    data['ref_Entry_By'] = this.refEntryBy;
    data['dtModifiedDate'] = this.dtModifiedDate;
    data['ref_Modified_By'] = this.refModifiedBy;
    data['dtValidFrom'] = this.dtValidFrom;
    data['dtValidTo'] = this.dtValidTo;
    data['varPrintingCode'] = this.varPrintingCode;
    data['refParentGlCode'] = this.refParentGlCode;
    data['varAPIToken'] = this.varAPIToken;
    data['varServerName'] = this.varServerName;
    data['chrCPM'] = this.chrCPM;
    data['chrICM'] = this.chrICM;
    data['chrAgree'] = this.chrAgree;
    data['varAgreementUrl'] = this.varAgreementUrl;
    data['chrStep2Registration'] = this.chrStep2Registration;
    data['varAddress1'] = this.varAddress1;
    data['varPincode'] = this.varPincode;
    data['fk_L3_PoliticalGeoGlCode'] = this.fkL3PoliticalGeoGlCode;
    data['fk_L2_PoliticalGeoGlCode'] = this.fkL2PoliticalGeoGlCode;
    data['fk_L1_PoliticalGeoGlCode'] = this.fkL1PoliticalGeoGlCode;
    data['varReferralCode'] = this.varReferralCode;
    data['strDateFormat_MSSQL'] = this.strDateFormatMSSQL;
    data['strTimeFormat_MSSQL'] = this.strTimeFormatMSSQL;
    data['strDateTimeFormat_MSSQL'] = this.strDateTimeFormatMSSQL;
    data['strDateFormat_SQLLite'] = this.strDateFormatSQLLite;
    data['strTimeFormat_SQLLite'] = this.strTimeFormatSQLLite;
    data['strDateTimeFormat_SQLLite'] = this.strDateTimeFormatSQLLite;
    data['varSync_Code'] = this.varSyncCode;
    data['dtSyncDate'] = this.dtSyncDate;
    data['chrGender'] = this.chrGender;
    data['varImageURL'] = this.varImageURL;
    return data;
  }
}

class SystemConfigurationMst {
  int? intGlCode;
  int? fkSubModuleGlCode;
  String? varVersion;
  String? dtEntryUpdateDate;
  String? varProjectName;
  String? varErrorCaption;
  String? varXMLSettings;

  SystemConfigurationMst(
      {this.intGlCode,
      this.fkSubModuleGlCode,
      this.varVersion,
      this.dtEntryUpdateDate,
      this.varProjectName,
      this.varErrorCaption,
      this.varXMLSettings});

  SystemConfigurationMst.fromJson(Map<String, dynamic> json) {
    intGlCode = json['intGlCode'];
    fkSubModuleGlCode = json['fk_SubModuleGlCode'];
    varVersion = json['varVersion'];
    dtEntryUpdateDate = json['dtEntryUpdateDate'];
    varProjectName = json['varProjectName'];
    varErrorCaption = json['varErrorCaption'];
    varXMLSettings = json['varXMLSettings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intGlCode'] = this.intGlCode;
    data['fk_SubModuleGlCode'] = this.fkSubModuleGlCode;
    data['varVersion'] = this.varVersion;
    data['dtEntryUpdateDate'] = this.dtEntryUpdateDate;
    data['varProjectName'] = this.varProjectName;
    data['varErrorCaption'] = this.varErrorCaption;
    data['varXMLSettings'] = this.varXMLSettings;
    return data;
  }
}

class MenuMst {
  int? intGlCode;
  String? varMenuName;
  String? varDisplayName;
  String? varURL;
  int? intMenuLevel;
  String? chrElementType;
  int? intDisplayOrder;
  String? varIconPath;
  String? chrDisplay;
  String? chrHeadType;
  String? chrMenuType;
  String? chrDBType;
  String? refParentMenuGLCode;
  String? varTransactionCode;
  String? refSubModuleGlCode;
  String? dtEntryDate;
  String? dtUpdateDate;
  int? fkEntryPersonGlCode;
  int? fkUpdatePersonGlCode;
  String? chrActive;
  String? chrSync;
  String? varSyncCode;
  String? dtSyncDate;
  String icon = '';

  MenuMst(
      {this.intGlCode,
      this.varMenuName,
      this.varDisplayName,
      this.varURL,
      this.intMenuLevel,
      this.chrElementType,
      this.intDisplayOrder,
      this.varIconPath,
      this.chrDisplay,
      this.chrHeadType,
      this.chrMenuType,
      this.chrDBType,
      this.refParentMenuGLCode,
      this.varTransactionCode,
      this.refSubModuleGlCode,
      this.dtEntryDate,
      this.dtUpdateDate,
      this.fkEntryPersonGlCode,
      this.fkUpdatePersonGlCode,
      this.chrActive,
      this.chrSync,
      this.varSyncCode,
      this.dtSyncDate});

  MenuMst.fromJson(Map<String, dynamic> json) {
    intGlCode = json['intGlCode'];
    varMenuName = json['varMenuName'];
    varDisplayName = json['varDisplayName'];
    varURL = json['varURL'];
    intMenuLevel = json['intMenu_Level'];
    chrElementType = json['chrElement_Type'];
    intDisplayOrder = json['intDisplay_Order'];
    varIconPath = json['varIconPath'];
    chrDisplay = json['chrDisplay'];
    chrHeadType = json['chrHeadType'];
    chrMenuType = json['chrMenuType'];
    chrDBType = json['chrDBType'];
    refParentMenuGLCode = json['refParentMenuGLCode'];
    varTransactionCode = json['varTransactionCode'];
    refSubModuleGlCode = json['refSubModuleGlCode'];
    dtEntryDate = json['dtEntryDate'];
    dtUpdateDate = json['dtUpdateDate'];
    fkEntryPersonGlCode = json['fk_EntryPersonGlCode'];
    fkUpdatePersonGlCode = json['fk_UpdatePersonGlCode'];
    chrActive = json['chrActive'];
    chrSync = json['chrSync'];
    varSyncCode = json['varSync_Code'];
    dtSyncDate = json['dtSyncDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intGlCode'] = this.intGlCode;
    data['varMenuName'] = this.varMenuName;
    data['varDisplayName'] = this.varDisplayName;
    data['varURL'] = this.varURL;
    data['intMenu_Level'] = this.intMenuLevel;
    data['chrElement_Type'] = this.chrElementType;
    data['intDisplay_Order'] = this.intDisplayOrder;
    data['varIconPath'] = this.varIconPath;
    data['chrDisplay'] = this.chrDisplay;
    data['chrHeadType'] = this.chrHeadType;
    data['chrMenuType'] = this.chrMenuType;
    data['chrDBType'] = this.chrDBType;
    data['refParentMenuGLCode'] = this.refParentMenuGLCode;
    data['varTransactionCode'] = this.varTransactionCode;
    data['refSubModuleGlCode'] = this.refSubModuleGlCode;
    data['dtEntryDate'] = this.dtEntryDate;
    data['dtUpdateDate'] = this.dtUpdateDate;
    data['fk_EntryPersonGlCode'] = this.fkEntryPersonGlCode;
    data['fk_UpdatePersonGlCode'] = this.fkUpdatePersonGlCode;
    data['chrActive'] = this.chrActive;
    data['chrSync'] = this.chrSync;
    data['varSync_Code'] = this.varSyncCode;
    data['dtSyncDate'] = this.dtSyncDate;
    return data;
  }

  static Map<String, dynamic> toMap(MenuMst MenuMst) => {
        'intGlCode': MenuMst.intGlCode,
        'varMenuName': MenuMst.varMenuName,
        'varDisplayName': MenuMst.varDisplayName,
        'varURL': MenuMst.varURL,
        'intMenu_Level': MenuMst.intMenuLevel,
        'chrElement_Type': MenuMst.chrElementType,
        'intDisplay_Order': MenuMst.intDisplayOrder,
        'varIconPath': MenuMst.varIconPath,
        'chrDisplay': MenuMst.chrDisplay,
        'chrHeadType': MenuMst.chrHeadType,
        'chrMenuType': MenuMst.chrMenuType,
        'chrDBType': MenuMst.chrDBType,
        'refParentMenuGLCode': MenuMst.refParentMenuGLCode,
        'varTransactionCode': MenuMst.varTransactionCode,
        'refSubModuleGlCode': MenuMst.refSubModuleGlCode,
        'dtEntryDate': MenuMst.dtEntryDate,
        'dtUpdateDate': MenuMst.dtUpdateDate,
        'fk_EntryPersonGlCode': MenuMst.fkEntryPersonGlCode,
        'fk_UpdatePersonGlCode': MenuMst.fkUpdatePersonGlCode,
        'chrActive': MenuMst.chrActive,
        'chrSync': MenuMst.chrSync,
        'varSync_Code': MenuMst.varSyncCode,
        'dtSyncDate': MenuMst.dtSyncDate,
      };
}

class DrawerItem {
  String? menuGlCode;
  String? title;
  String? icon;
  String? chrDisplay;
  String? varTransactionCode;
  bool? isVisible;
  int? intDisplay_Order;

  DrawerItem(
      {this.title,
      this.icon,
      this.chrDisplay,
      this.varTransactionCode,
      this.menuGlCode,
      this.isVisible,
      this.intDisplay_Order});

  factory DrawerItem.fromJson(Map<String, dynamic> jsonData) {
    return DrawerItem(
      title: jsonData['title'],
      icon: jsonData['icon'],
      chrDisplay: jsonData['chrDisplay'],
      varTransactionCode: jsonData['varTransactionCode'],
      menuGlCode: jsonData['menuGlCode'],
      isVisible: jsonData['isVisible'],
      intDisplay_Order: jsonData.containsKey('intDisplay_Order')
          ? jsonData['intDisplay_Order']
          : 0,
    );
  }

  static Map<String, dynamic> toMap(DrawerItem DrawerItem) => {
        'title': DrawerItem.title,
        'icon': DrawerItem.icon,
        'chrDisplay': DrawerItem.chrDisplay,
        'varTransactionCode': DrawerItem.varTransactionCode,
        'menuGlCode': DrawerItem.menuGlCode,
        'isVisible': DrawerItem.isVisible,
        'intDisplay_Order': DrawerItem.intDisplay_Order,
      };
}
