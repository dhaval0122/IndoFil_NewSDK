class bf_ishop_farmer_dispatch_online {
  String? farmer_dispatch_id;
  String? customer_from_id;
  String? customer_to_id;
  String? customer_type_country_id;
  String? dispatch_date;
  String? country_id;
  String? created_by_user;
  String? modified_by_user;
  String? status;
  String? created_on;
  String? modified_on;
  String? sync_code;
  String? sync_flag;
  String? sync_date;
  String? sync_by_user;

  bf_ishop_farmer_dispatch_online(
      this.farmer_dispatch_id,
      this.customer_from_id,
      this.customer_to_id,
      this.customer_type_country_id,
      this.dispatch_date,
      this.country_id,
      this.created_by_user,
      this.modified_by_user,
      this.status,
      this.created_on,
      this.modified_on,
      this.sync_code,
      this.sync_flag,
      this.sync_date,
      this.sync_by_user);

  bf_ishop_farmer_dispatch_online.fromJson(Map<String, dynamic> json)
      : farmer_dispatch_id = json['farmer_dispatch_id'],
        customer_from_id = json['customer_from_id'],
        customer_to_id = json['customer_to_id'],
        customer_type_country_id = json['customer_type_country_id'],
        dispatch_date = json['dispatch_date'],
        country_id = json['country_id'],
        created_by_user = json['created_by_user'],
        modified_by_user = json['modified_by_user'],
        status = json['status'],
        created_on = json['created_on'],
        modified_on = json['modified_on'],
        sync_code = json['sync_code'],
        sync_flag = json['sync_flag'],
        sync_date = json['sync_date'],
        sync_by_user = json['sync_by_user'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['farmer_dispatch_id'] = this.farmer_dispatch_id;
    data['customer_from_id'] = this.customer_from_id;
    data['customer_to_id'] = this.customer_to_id;
    data['customer_type_country_id'] = this.customer_type_country_id;
    data['dispatch_date'] = this.dispatch_date;
    data['country_id'] = this.country_id;
    data['created_by_user'] = this.created_by_user;
    data['modified_by_user'] = this.modified_by_user;
    data['status'] = this.status;
    data['created_on'] = this.created_on;
    data['modified_on'] = this.modified_on;
    data['sync_code'] = this.sync_code;
    data['sync_flag'] = this.sync_flag;
    data['sync_date'] = this.sync_date;
    data['sync_by_user'] = this.sync_by_user;

    return data;
  }
}

class bf_ishop_farmer_dispatch_product {
  String? farmer_dispatch_product_id;
  String? farmer_dispatch_id;
  String? product_sku_id;
  String? sku_sticker_details_id;
  String? btc_no;
  String? qr_code;
  String? btc_type;
  String? quantity;
  String? unit;
  String? is_valid;
  String? is_point;
  String? received;
  String? received_date;
  String? sync_code;
  String? sync_flag;
  String? sync_date;
  String? sync_by_user;
  int toastMessageCount = 0;

  bf_ishop_farmer_dispatch_product(
      this.farmer_dispatch_product_id,
      this.farmer_dispatch_id,
      this.product_sku_id,
      this.sku_sticker_details_id,
      this.btc_no,
      this.qr_code,
      this.btc_type,
      this.quantity,
      this.unit,
      this.is_valid,
      this.is_point,
      this.received,
      this.received_date,
      this.sync_code,
      this.sync_flag,
      this.sync_date,
      this.sync_by_user);

  bf_ishop_farmer_dispatch_product.fromJson(Map<String, dynamic> json)
      : farmer_dispatch_product_id = json['farmer_dispatch_product_id'],
        farmer_dispatch_id = json['farmer_dispatch_id'],
        product_sku_id = json['product_sku_id'],
        sku_sticker_details_id = json['sku_sticker_details_id'],
        btc_no = json['btc_no'],
        qr_code = json['qr_code'],
        btc_type = json['btc_type'],
        quantity = json['quantity'],
        unit = json['unit'],
        is_valid = json['is_valid'],
        is_point = json['is_point'],
        received = json['received'],
        received_date = json['received_date'],
        sync_code = json['sync_code'],
        sync_flag = json['sync_flag'],
        sync_date = json['sync_date'],
        sync_by_user = json['sync_by_user'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['farmer_dispatch_product_id'] = this.farmer_dispatch_product_id;
    data['farmer_dispatch_id'] = this.farmer_dispatch_id;
    data['product_sku_id'] = this.product_sku_id;
    data['sku_sticker_details_id'] = this.sku_sticker_details_id;
    data['btc_no'] = this.btc_no;
    data['qr_code'] = this.qr_code;
    data['btc_type'] = this.btc_type;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['is_valid'] = this.is_valid;
    data['is_point'] = this.is_point;
    data['received'] = this.received;
    data['received_date'] = this.received_date;
    data['sync_code'] = this.sync_code;
    data['sync_flag'] = this.sync_flag;
    data['sync_date'] = this.sync_date;
    data['sync_by_user'] = this.sync_by_user;

    return data;
  }
}

class StickerList {
  String btc_no;
  String is_valid;
  int toastMessageCount = 0;

  StickerList(this.btc_no, this.is_valid);
}

class ScanEarnPoint {
  String? chrEarnPoint;
  double? decEarnPoint;

  ScanEarnPoint({this.chrEarnPoint, this.decEarnPoint});

  ScanEarnPoint.fromJson(Map<String, dynamic> json) {
    chrEarnPoint = json['chrEarnPoint'];
    decEarnPoint = json['decEarnPoint'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['chrEarnPoint'] = this.chrEarnPoint;
    data['decEarnPoint'] = this.decEarnPoint;
    return data;
  }
}
