class SetLocationModel {
  String? user_id;
  String? latitude;
  String? longitude;

  SetLocationModel({this.user_id, this.latitude, this.longitude});

  SetLocationModel.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = this.user_id;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;

    return data;
  }
}
