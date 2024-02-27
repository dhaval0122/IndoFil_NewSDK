class ProfileResModel {
  String? varUserID;
  String? varFirstName;
  String? varLastName;
  String? fullname;
  String? varOrganisationName;
  String? chrUserType;
  String? varUserType;
  String? varEmail;
  String? varMobileNo;
  String? varAddress;
  String? varPincode;
  String? chrGender;
  String? varImageURL;
  String? varAssignedRole;
  String? chr2FA;
  String? chr2FATimer;

  ProfileResModel(
      {this.varUserID,
      this.varFirstName,
      this.varLastName,
      this.fullname,
      this.varOrganisationName,
      this.chrUserType,
      this.varUserType,
      this.varEmail,
      this.varMobileNo,
      this.varAddress,
      this.varPincode,
      this.chrGender,
      this.varImageURL,
      this.varAssignedRole,
      this.chr2FA,
      this.chr2FATimer});

  ProfileResModel.fromJson(Map<String, dynamic> json) {
    varUserID = json['varUserID'];
    varFirstName = json['varFirstName'];
    varLastName = json['varLastName'];
    fullname = json['Fullname'];
    varOrganisationName = json['varOrganisationName'];
    chrUserType = json['chrUserType'];
    varUserType = json['varUserType'];
    varEmail = json['varEmail'];
    varMobileNo = json['varMobileNo'];
    varAddress = json['varAddress'];
    varPincode = json['varPincode'];
    chrGender = json['chrGender'];
    varImageURL = json['varImageURL'];
    varAssignedRole = json['varAssignedRole'];
    chr2FA = json['chr2FA'];
    chr2FATimer = json['chr2FATimer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['varUserID'] = this.varUserID;
    data['varFirstName'] = this.varFirstName;
    data['varLastName'] = this.varLastName;
    data['Fullname'] = this.fullname;
    data['varOrganisationName'] = this.varOrganisationName;
    data['chrUserType'] = this.chrUserType;
    data['varUserType'] = this.varUserType;
    data['varEmail'] = this.varEmail;
    data['varMobileNo'] = this.varMobileNo;
    data['varAddress'] = this.varAddress;
    data['varPincode'] = this.varPincode;
    data['chrGender'] = this.chrGender;
    data['varImageURL'] = this.varImageURL;
    data['varAssignedRole'] = this.varAssignedRole;
    data['chr2FA'] = this.chr2FA;
    data['chr2FATimer'] = this.chr2FATimer;
    return data;
  }
}
