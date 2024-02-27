class SelectData {
  String? address;
  String? geoLevelId4;
  String? geoLevelId3;
  String? geoLevelId2;
  String? pincode;
  String? latitude;
  String? longitude;

  SelectData(
      {this.address,
      this.geoLevelId4,
      this.geoLevelId3,
      this.geoLevelId2,
      this.pincode,
      this.latitude,
      this.longitude});

  SelectData.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    geoLevelId4 = json['geo_level_id4'];
    geoLevelId3 = json['geo_level_id3'];
    geoLevelId2 = json['geo_level_id2'];
    pincode = json['pincode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['geo_level_id4'] = this.geoLevelId4;
    data['geo_level_id3'] = this.geoLevelId3;
    data['geo_level_id2'] = this.geoLevelId2;
    data['pincode'] = this.pincode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
