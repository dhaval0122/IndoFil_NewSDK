class CheckUpdate {
  String? status;
  String? message;
  Response? response;

  CheckUpdate({this.status, this.message, this.response});

  CheckUpdate.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    response = json['Response'] != null
        ? new Response.fromJson(json['Response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.response != null) {
      data['Response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  List<SystemInformation>? systemInformation;

  Response({this.systemInformation});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['SystemInformation'] != null) {
      systemInformation = <SystemInformation>[];
      json['SystemInformation'].forEach((v) {
        systemInformation!.add(SystemInformation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = new Map<String, dynamic>();
    if (systemInformation != null) {
      data['SystemInformation'] =
          systemInformation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SystemInformation {
  String? varVersion;
  String? varFilePath;
  String? varBrowserFilePath;

  SystemInformation(
      {this.varVersion, this.varFilePath, this.varBrowserFilePath});

  SystemInformation.fromJson(Map<String, dynamic> json) {
    varVersion = json['varVersion'];
    varFilePath = json['varFilePath'];
    varBrowserFilePath = json['varBrowserFilePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['varVersion'] = this.varVersion;
    data['varFilePath'] = this.varFilePath;
    data['varBrowserFilePath'] = this.varBrowserFilePath;
    return data;
  }
}

class CheckUpdateVersion {
  String? status;
  String? message;
  String? file;
  String? browserFile;
  Response? response;

  CheckUpdateVersion(
      {this.status, this.message, this.file, this.browserFile, this.response});

  CheckUpdateVersion.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    file = json['File'];
    browserFile = json['BrowserFile'];
    response =
        json['Response'] != null ? Response.fromJson(json['Response']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    data['File'] = this.file;
    data['BrowserFile'] = this.browserFile;
    if (this.response != null) {
      data['Response'] = this.response!.toJson();
    }
    return data;
  }
}
