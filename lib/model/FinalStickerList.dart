class FinalStickerListModel {
  List<BfIshopFarmerDispatchProduct>? bfIshopFarmerDispatchProduct;
  List<BfIshopFarmerDispatch>? bfIshopFarmerDispatch;
  List<BfIshopFarmerDispatchColumn>? bfIshopFarmerDispatchColumn;
  List<BfIshopFarmerDispatchProductColumn>? bfIshopFarmerDispatchProductColumn;
  List<Msg>? msg;

  FinalStickerListModel(
      {this.bfIshopFarmerDispatchProduct,
      this.bfIshopFarmerDispatch,
      this.bfIshopFarmerDispatchColumn,
      this.bfIshopFarmerDispatchProductColumn,
      this.msg});

  FinalStickerListModel.fromJson(Map<String, dynamic> json) {
    if (json['bf_ishop_farmer_dispatch_product'] != null) {
      bfIshopFarmerDispatchProduct = <BfIshopFarmerDispatchProduct>[];
      json['bf_ishop_farmer_dispatch_product'].forEach((v) {
        bfIshopFarmerDispatchProduct!
            .add(BfIshopFarmerDispatchProduct.fromJson(v));
      });
    }
    if (json['bf_ishop_farmer_dispatch'] != null) {
      bfIshopFarmerDispatch = <BfIshopFarmerDispatch>[];
      json['bf_ishop_farmer_dispatch'].forEach((v) {
        bfIshopFarmerDispatch!.add(BfIshopFarmerDispatch.fromJson(v));
      });
    }
    if (json['bf_ishop_farmer_dispatch_column'] != null) {
      bfIshopFarmerDispatchColumn = <BfIshopFarmerDispatchColumn>[];
      json['bf_ishop_farmer_dispatch_column'].forEach((v) {
        bfIshopFarmerDispatchColumn!
            .add(BfIshopFarmerDispatchColumn.fromJson(v));
      });
    }
    if (json['bf_ishop_farmer_dispatch__product_column'] != null) {
      bfIshopFarmerDispatchProductColumn =
          <BfIshopFarmerDispatchProductColumn>[];
      json['bf_ishop_farmer_dispatch__product_column'].forEach((v) {
        bfIshopFarmerDispatchProductColumn!
            .add(BfIshopFarmerDispatchProductColumn.fromJson(v));
      });
    }
    if (json['msg'] != null) {
      msg = <Msg>[];
      json['msg'].forEach((v) {
        msg!.add(Msg.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.bfIshopFarmerDispatchProduct != null) {
      data['bf_ishop_farmer_dispatch_product'] =
          this.bfIshopFarmerDispatchProduct!.map((v) => v.toJson()).toList();
    }
    if (this.bfIshopFarmerDispatch != null) {
      data['bf_ishop_farmer_dispatch'] =
          this.bfIshopFarmerDispatch!.map((v) => v.toJson()).toList();
    }
    if (this.bfIshopFarmerDispatchColumn != null) {
      data['bf_ishop_farmer_dispatch_column'] =
          this.bfIshopFarmerDispatchColumn!.map((v) => v.toJson()).toList();
    }
    if (this.bfIshopFarmerDispatchProductColumn != null) {
      data['bf_ishop_farmer_dispatch__product_column'] = this
          .bfIshopFarmerDispatchProductColumn!
          .map((v) => v.toJson())
          .toList();
    }
    if (this.msg != null) {
      data['msg'] = this.msg!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BfIshopFarmerDispatchProduct {
  String? a;
  String? b;
  String? c;
  String? d;
  String? e;
  String? f;
  String? g;
  String? h;
  String? i;
  String? j;
  String? k;
  String? l;
  String? m;
  String? n;
  String? o;
  String? p;
  String? q;

  BfIshopFarmerDispatchProduct(
      {this.a,
      this.b,
      this.c,
      this.d,
      this.e,
      this.f,
      this.g,
      this.h,
      this.i,
      this.j,
      this.k,
      this.l,
      this.m,
      this.n,
      this.o,
      this.p,
      this.q});

  BfIshopFarmerDispatchProduct.fromJson(Map<String, dynamic> json) {
    a = json['A'];
    b = json['B'];
    c = json['C'];
    d = json['D'];
    e = json['E'];
    f = json['F'];
    g = json['G'];
    h = json['H'];
    i = json['I'];
    j = json['J'];
    k = json['K'];
    l = json['L'];
    m = json['M'];
    n = json['N'];
    o = json['O'];
    p = json['P'];
    q = json['Q'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['A'] = this.a;
    data['B'] = this.b;
    data['C'] = this.c;
    data['D'] = this.d;
    data['E'] = this.e;
    data['F'] = this.f;
    data['G'] = this.g;
    data['H'] = this.h;
    data['I'] = this.i;
    data['J'] = this.j;
    data['K'] = this.k;
    data['L'] = this.l;
    data['M'] = this.m;
    data['N'] = this.n;
    data['O'] = this.o;
    data['P'] = this.p;
    data['Q'] = this.q;
    return data;
  }
}

class BfIshopFarmerDispatch {
  String? a;
  String? b;
  String? c;
  String? d;
  String? e;
  String? f;
  String? g;
  String? h;
  String? i;
  String? j;
  String? k;
  String? l;
  String? m;
  String? n;
  String? o;

  BfIshopFarmerDispatch(
      {this.a,
      this.b,
      this.c,
      this.d,
      this.e,
      this.f,
      this.g,
      this.h,
      this.i,
      this.j,
      this.k,
      this.l,
      this.m,
      this.n,
      this.o});

  BfIshopFarmerDispatch.fromJson(Map<String, dynamic> json) {
    a = json['A'];
    b = json['B'];
    c = json['C'];
    d = json['D'];
    e = json['E'];
    f = json['F'];
    g = json['G'];
    h = json['H'];
    i = json['I'];
    j = json['J'];
    k = json['K'];
    l = json['L'];
    m = json['M'];
    n = json['N'];
    o = json['O'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['A'] = this.a;
    data['B'] = this.b;
    data['C'] = this.c;
    data['D'] = this.d;
    data['E'] = this.e;
    data['F'] = this.f;
    data['G'] = this.g;
    data['H'] = this.h;
    data['I'] = this.i;
    data['J'] = this.j;
    data['K'] = this.k;
    data['L'] = this.l;
    data['M'] = this.m;
    data['N'] = this.n;
    data['O'] = this.o;
    return data;
  }
}

class BfIshopFarmerDispatchColumn {
  String? farmerDispatchId;
  String? customerFromId;
  String? customerToId;
  String? customerTypeCountryId;
  String? dispatchDate;
  String? countryId;
  String? createdByUser;
  String? modifiedByUser;
  String? status;
  String? createdOn;
  String? modifiedOn;
  String? syncCode;
  String? syncFlag;
  String? syncDate;
  String? syncByUser;

  BfIshopFarmerDispatchColumn(
      {this.farmerDispatchId,
      this.customerFromId,
      this.customerToId,
      this.customerTypeCountryId,
      this.dispatchDate,
      this.countryId,
      this.createdByUser,
      this.modifiedByUser,
      this.status,
      this.createdOn,
      this.modifiedOn,
      this.syncCode,
      this.syncFlag,
      this.syncDate,
      this.syncByUser});

  BfIshopFarmerDispatchColumn.fromJson(Map<String, dynamic> json) {
    farmerDispatchId = json['farmer_dispatch_id'];
    customerFromId = json['customer_from_id'];
    customerToId = json['customer_to_id'];
    customerTypeCountryId = json['customer_type_country_id'];
    dispatchDate = json['dispatch_date'];
    countryId = json['country_id'];
    createdByUser = json['created_by_user'];
    modifiedByUser = json['modified_by_user'];
    status = json['status'];
    createdOn = json['created_on'];
    modifiedOn = json['modified_on'];
    syncCode = json['sync_code'];
    syncFlag = json['sync_flag'];
    syncDate = json['sync_date'];
    syncByUser = json['sync_by_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['farmer_dispatch_id'] = this.farmerDispatchId;
    data['customer_from_id'] = this.customerFromId;
    data['customer_to_id'] = this.customerToId;
    data['customer_type_country_id'] = this.customerTypeCountryId;
    data['dispatch_date'] = this.dispatchDate;
    data['country_id'] = this.countryId;
    data['created_by_user'] = this.createdByUser;
    data['modified_by_user'] = this.modifiedByUser;
    data['status'] = this.status;
    data['created_on'] = this.createdOn;
    data['modified_on'] = this.modifiedOn;
    data['sync_code'] = this.syncCode;
    data['sync_flag'] = this.syncFlag;
    data['sync_date'] = this.syncDate;
    data['sync_by_user'] = this.syncByUser;
    return data;
  }
}

class BfIshopFarmerDispatchProductColumn {
  String? farmerDispatchProductId;
  String? farmerDispatchId;
  String? productSkuId;
  String? skuStickerDetailsId;
  String? btcNo;
  String? qrCode;
  String? btcType;
  String? quantity;
  String? unit;
  String? isValid;
  String? isPoint;
  String? received;
  String? receivedDate;
  String? syncCode;
  String? syncFlag;
  String? syncDate;
  String? syncByUser;

  BfIshopFarmerDispatchProductColumn(
      {this.farmerDispatchProductId,
      this.farmerDispatchId,
      this.productSkuId,
      this.skuStickerDetailsId,
      this.btcNo,
      this.qrCode,
      this.btcType,
      this.quantity,
      this.unit,
      this.isValid,
      this.isPoint,
      this.received,
      this.receivedDate,
      this.syncCode,
      this.syncFlag,
      this.syncDate,
      this.syncByUser});

  BfIshopFarmerDispatchProductColumn.fromJson(Map<String, dynamic> json) {
    farmerDispatchProductId = json['farmer_dispatch_product_id'];
    farmerDispatchId = json['farmer_dispatch_id'];
    productSkuId = json['product_sku_id'];
    skuStickerDetailsId = json['sku_sticker_details_id'];
    btcNo = json['btc_no'];
    qrCode = json['qr_code'];
    btcType = json['btc_type'];
    quantity = json['quantity'];
    unit = json['unit'];
    isValid = json['is_valid'];
    isPoint = json['is_point'];
    received = json['received'];
    receivedDate = json['received_date'];
    syncCode = json['sync_code'];
    syncFlag = json['sync_flag'];
    syncDate = json['sync_date'];
    syncByUser = json['sync_by_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['farmer_dispatch_product_id'] = this.farmerDispatchProductId;
    data['farmer_dispatch_id'] = this.farmerDispatchId;
    data['product_sku_id'] = this.productSkuId;
    data['sku_sticker_details_id'] = this.skuStickerDetailsId;
    data['btc_no'] = this.btcNo;
    data['qr_code'] = this.qrCode;
    data['btc_type'] = this.btcType;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['is_valid'] = this.isValid;
    data['is_point'] = this.isPoint;
    data['received'] = this.received;
    data['received_date'] = this.receivedDate;
    data['sync_code'] = this.syncCode;
    data['sync_flag'] = this.syncFlag;
    data['sync_date'] = this.syncDate;
    data['sync_by_user'] = this.syncByUser;
    return data;
  }
}

class Msg {
  String? id;
  String? msg;
  String? scount;
  String? total;
  String? color;
  List<Sticker>? sticker;

  Msg({this.id, this.msg, this.scount, this.total, this.color, this.sticker});

  Msg.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    msg = json['msg'];
    scount = json['scount'];
    total = json['total'];
    color = json['color'];
    if (json['sticker'] != null) {
      sticker = <Sticker>[];
      json['sticker'].forEach((v) {
        sticker!.add(Sticker.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['msg'] = this.msg;
    data['scount'] = this.scount;
    data['total'] = this.total;
    data['color'] = this.color;
    if (this.sticker != null) {
      data['sticker'] = this.sticker!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sticker {
  String? btcNo;
  String? invalidStatus;

  Sticker({this.btcNo, this.invalidStatus});

  Sticker.fromJson(Map<String, dynamic> json) {
    btcNo = json['btc_no'];
    invalidStatus = json['invalid_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['btc_no'] = this.btcNo;
    data['invalid_status'] = this.invalidStatus;
    return data;
  }
}
