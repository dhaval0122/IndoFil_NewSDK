class Retailer {
  List<MappedRetailer>? mappedRetailer;
  List<MappedRetailer>? suggestRetailer;
  List<MappedRetailer>? pastSelected;
  List<MappedRetailer>? nearBy;

  Retailer(
      {this.mappedRetailer,
      this.suggestRetailer,
      this.pastSelected,
      this.nearBy});

  Retailer.fromJson(Map<String, dynamic> json) {
    if (json['mapped_retailer'] != null) {
      mappedRetailer = <MappedRetailer>[];
      json['mapped_retailer'].forEach((v) {
        mappedRetailer!.add(MappedRetailer.fromJson(v));
      });
    }
    if (json['suggest_retailer'] != null) {
      suggestRetailer = <MappedRetailer>[];
      json['suggest_retailer'].forEach((v) {
        suggestRetailer!.add(MappedRetailer.fromJson(v));
      });
    }
    if (json['past_selected'] != null) {
      pastSelected = <MappedRetailer>[];
      json['past_selected'].forEach((v) {
        pastSelected!.add(MappedRetailer.fromJson(v));
      });
    }
    if (json['near_by'] != null) {
      nearBy = <MappedRetailer>[];
      json['near_by'].forEach((v) {
        nearBy!.add(MappedRetailer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.mappedRetailer != null) {
      data['mapped_retailer'] =
          this.mappedRetailer!.map((v) => v.toJson()).toList();
    }
    if (this.suggestRetailer != null) {
      data['suggest_retailer'] =
          this.suggestRetailer!.map((v) => v.toJson()).toList();
    }
    if (this.pastSelected != null) {
      data['past_selected'] =
          this.pastSelected!.map((v) => v.toJson()).toList();
    }
    if (this.nearBy != null) {
      data['near_by'] = this.nearBy!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MappedRetailer {
  String? intId;
  String? custId;
  String? custCode;
  String? custName;
  String? custAddress;
  String? custMob;
  bool? isTab = false;

  MappedRetailer(
      {this.intId,
      this.custId,
      this.custCode,
      this.custName,
      this.custAddress,
      this.custMob,
      this.isTab});

  MappedRetailer.fromJson(Map<String, dynamic> json) {
    intId = json['intId'];
    custId = json['custId'];
    custCode = json['custCode'];
    custName = json['custName'];
    custAddress = json['custAddress'];
    custMob = json['custMob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['intId'] = this.intId;
    data['custId'] = this.custId;
    data['custCode'] = this.custCode;
    data['custName'] = this.custName;
    data['custAddress'] = this.custAddress;
    data['custMob'] = this.custMob;
    return data;
  }
}
