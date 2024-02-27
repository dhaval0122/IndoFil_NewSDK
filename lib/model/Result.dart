import 'LoginResponseModel.dart';

class Result {
  bool? status;
  String? message;
  List<LoginResModel>? data;

//  Version version;
//  MenuAccess menuAccess;

  Result({
    this.status,
    this.message,
    this.data,
    /*this.version, this.menuAccess*/
  });

  Result.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LoginResModel>[];
      json['data'].forEach((v) {
        data!.add(LoginResModel.fromJson(v));
      });
    }
//    version =
//        json['version'] != null ? Version.fromJson(json['version']) : null;
//    menuAccess = json['menu_access'] != null
//        ? MenuAccess.fromJson(json['menu_access'])
//        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
//    if (this.version != null) {
//      data['version'] = this.version.toJson();
//    }
//    if (this.menuAccess != null) {
//      data['menu_access'] = this.menuAccess.toJson();
//    }
    return data;
  }
}
