//import 'package:flutter_basf_hk_app/UI/ProductInformation.dart';
import 'package:flutter_basf_hk_app/model/ContactUsRetailer.dart';
import 'package:flutter_basf_hk_app/model/KeyDetailModel.dart';
import 'package:flutter_basf_hk_app/model/Lang.dart';
import 'package:flutter_basf_hk_app/model/LoginInfo.dart';
import 'package:flutter_basf_hk_app/model/LoginResponseModel.dart';
import 'package:flutter_basf_hk_app/model/MappedRetailer.dart';
import 'package:flutter_basf_hk_app/model/NotificationModel.dart';
import 'package:flutter_basf_hk_app/model/POScanningDetails.dart';
import 'package:flutter_basf_hk_app/model/PreFillKeyDetails.dart';
import 'package:flutter_basf_hk_app/model/ProductInfoLink.dart';
import 'package:flutter_basf_hk_app/model/ProfileResponceModel.dart';

import 'BASFContactInformation.dart';
import 'CountryModel.dart';
import 'CustomerInformation.dart';
import 'PGIModel.dart';
import 'PassbookData.dart';
import 'PoliticalGeoLevel.dart';
import 'ProductData.dart';
import 'SetLocationModel.dart';
import 'StickerInfo.dart';
import 'StickerModel.dart';

class GeneralResponseModel {
  String? status;
  String? message;
  String? file;
  String? browserFile;
  var response;

  factory GeneralResponseModel.fromJsonStatus(Map<String, dynamic> json) {
    String message = json['Message'];

    if (message.contains("\\n")) {
      message = message.replaceAll('\\n', '\n');
    }

    if (message.contains("\\r")) {
      message = message.replaceAll('\\r', '\r');
    }

    return GeneralResponseModel(
      status: json['Status'],
      message: message,
      file: json['File'] != null ? json['File'] : null,
      browserFile: json['BrowserFile'] != null ? json['BrowserFile'] : null,
      response: json['Response'],
    );
  }

  GeneralResponseModel(
      {this.status, this.message, this.file, this.browserFile, this.response});

  List<StickerInfo> getStickerInfo() {
    List<StickerInfo> list = [];
    if (response.containsKey('StickerInfo')) {
      var listTmp = response['StickerInfo'] as List;
      list = listTmp.map((i) => StickerInfo.fromJson(i)).toList();
    }
    return list;
  }

  List<DefaultLanguageDetails> getDefaultLanguageList() {
    var defaultList = <DefaultLanguageDetails>[];
    if (response.containsKey('DefaultLanguageDetails')) {
      var listTmp = response['DefaultLanguageDetails'] as List;
      defaultList =
          listTmp.map((i) => DefaultLanguageDetails.fromJson(i)).toList();
    }
    return defaultList;
  }

  List<Country> getCountryList() {
    List<Country> list = [];
    if (response.containsKey('Country')) {
      var listTmp = response['Country'] as List;
      list = listTmp.map((i) => Country.fromJson(i)).toList();
    }
    return list;
  }

  List<CustomerType> getCustomerTypeList() {
    List<CustomerType> list = [];
    if (response.containsKey('CustomerType')) {
      var listTmp = response['CustomerType'] as List;
      list = listTmp.map((i) => CustomerType.fromJson(i)).toList();
    }
    return list;
  }

  PersonMst? getLoginDetail() {
    PersonMst? personMst;
    if (response.containsKey('Person_Mst')) {
      var listTmp = response['Person_Mst'] as List;
      listTmp.map((i) {
        personMst = PersonMst.fromJson(i);
      }).toList();
    }
    return personMst;
  }

  String? getUrlFromSticker() {
    String? url = '';
    List<ProductInfoLink> list = <ProductInfoLink>[];
    if (response.containsKey('ProductInfoLink')) {
      var listTmp = response['ProductInfoLink'] as List;
      list = listTmp.map((i) => ProductInfoLink.fromJson(i)).toList();
    }
    if (list != null && list.isNotEmpty) {
      url = list[0].varQRCode;
    }

    return url;
  }

  List<MenuMst> getMenuAccess() {
    List<MenuMst> menuAccess = [];
    if (response.containsKey('Menu_Mst')) {
      var listTmp = response['Menu_Mst'] as List;
      menuAccess = listTmp.map((i) => MenuMst.fromJson(i)).toList();
    }
    return menuAccess;
  }

  List<ProductDetails> getProductDetails() {
    List<ProductDetails> productList = [];
    if (response.containsKey('PRD')) {
      response['PRD'].forEach((v) {
        productList.add(ProductDetails.fromJson(v));
      });
    }
    return productList;
  }

  List<CropDetails> getCropFromMaster() {
    List<CropDetails> cropList = [];
    if (response.containsKey('CROP')) {
      response['CROP'].forEach((v) {
        cropList.add(CropDetails.fromJson(v));
      });
    }
    return cropList;
  }

  List<ProductDetails> getProductFromMaster() {
    List<ProductDetails> cropList = [];
    if (response.containsKey('PRD')) {
      response['PRD'].forEach((v) {
        cropList.add(ProductDetails.fromJson(v));
      });
    }
    return cropList;
  }

  List<CropDetails> getCropList() {
    List<CropDetails> cropList = [];
    if (response.containsKey('Crop')) {
      response['Crop'].forEach((v) {
        cropList.add(CropDetails.fromJson(v));
      });
    }
    return cropList;
  }

  List<ScanEarnPoint> getEarnPointDetail() {
    List<ScanEarnPoint> earnPoints = [];
    if (response.containsKey("EarnPoint")) {
      response["EarnPoint"].forEach((v) {
        earnPoints.add(ScanEarnPoint.fromJson(v));
      });
    }
    return earnPoints;
  }

  List<MappedRetailer> getNearByRetailerDetail() {
    List<MappedRetailer> retailerModel = [];
    if (response.containsKey('near_by')) {
      response['near_by'].forEach((v) {
        retailerModel.add(MappedRetailer.fromJson(v));
      });
    }
    return retailerModel;
  }

  List<MappedRetailer> getPastSelectRetailerDetail() {
    List<MappedRetailer> retailerModel = [];
    if (response.containsKey('past_selected')) {
      response['past_selected'].forEach((v) {
        retailerModel.add(MappedRetailer.fromJson(v));
      });
    }
    return retailerModel;
  }

  List<MappedRetailer> getMappedRetailerDetail() {
    List<MappedRetailer> retailerModel = [];
    if (response.containsKey('mapped_retailer')) {
      response['mapped_retailer'].forEach((v) {
        retailerModel.add(MappedRetailer.fromJson(v));
      });
    }
    return retailerModel;
  }

  List<MappedRetailer> getSuggestRetailerDetail() {
    List<MappedRetailer> retailerModel = [];
    if (response.containsKey('suggest_retailer')) {
      response['suggest_retailer'].forEach((v) {
        retailerModel.add(MappedRetailer.fromJson(v));
      });
    }
    return retailerModel;
  }

  List<BASFContactInformation> getBASF_Contact_Information() {
    List<BASFContactInformation> retailerList = [];
    if (response.containsKey("BASF_Contact_Information")) {
      response["BASF_Contact_Information"].forEach((v) {
        retailerList.add(BASFContactInformation.fromJson(v));
      });
    }
    return retailerList;
  }

  List<ContactUsRetailer> getRetailerList() {
    List<ContactUsRetailer> retailerList = [];
    if (response.containsKey("Customer_Information")) {
      response["Customer_Information"].forEach((v) {
        retailerList.add(ContactUsRetailer.fromJson(v));
      });
    }
    return retailerList;
  }

  List<ContactUsRetailer> getEmployeeList() {
    List<ContactUsRetailer> retailerList = [];
    if (response.containsKey('Employee_Information')) {
      response['Employee_Information'].forEach((v) {
        retailerList.add(ContactUsRetailer.fromJson(v));
      });
    }
    return retailerList;
  }

  List<CustomerInformation> getNearByRetailer() {
    List<CustomerInformation> retailerList = [];
    if (response.containsKey('CustomerInformation')) {
      response['CustomerInformation'].forEach((v) {
        retailerList.add(CustomerInformation.fromJson(v));
      });
    }
    return retailerList;
  }

  List<PreFillKeyDetails> getPreFillData() {
    List<PreFillKeyDetails> retailerList = [];
    if (response.containsKey('Customer_Information')) {
      response['Customer_Information'].forEach((v) {
        retailerList.add(PreFillKeyDetails.fromJson(v));
      });
    }
    return retailerList;
  }

  SetLocationModel? getLocationData() {
    SetLocationModel? profileResModel;
    if (response.containsKey('data')) {
      var listTmp = response['data'] as List;
      print(listTmp);
      listTmp.map((i) {
        profileResModel = SetLocationModel.fromJson(i);
      }).toList();
    }
    return profileResModel;
  }

  ProfileResModel? getProfileDetail() {
    ProfileResModel? profileResModel;
    if (response.containsKey('Profile_Data')) {
      var listTmp = response['Profile_Data'] as List;
      print(listTmp);
      listTmp.map((i) {
        profileResModel = ProfileResModel.fromJson(i);
      }).toList();
    }
    return profileResModel;
  }

  List<DataList> getProductDataListOffer() {
    List<DataList> dataList = [];

    if (response.containsKey('Offer_Running')) {
      response['Offer_Running'].forEach((v) {
        dataList.add(DataList.fromJson(v));
      });
    }
    return dataList;
  }

  List<DataList> getOfferDataList() {
    List<DataList> dataList = [];
    if (response.containsKey('data')) {
      response['data'].forEach((v) {
        dataList.add(DataList.fromJson(v));
      });
    }
    return dataList;
  }

  List<ProductDataList> getOfferProductDataList() {
    List<ProductDataList> prdDataList = [];
    if (response.containsKey('product_data')) {
      response['product_data'].forEach((v) {
        prdDataList.add(ProductDataList.fromJson(v));
      });
    }
    return prdDataList;
  }

  List<EarnPoint> getCurrentPointList() {
    List<EarnPoint> dataList = [];
    if (response.containsKey('EarnPoint')) {
      response['EarnPoint'].forEach((v) {
        print("dd---" + v.toString());
        dataList.add(EarnPoint.fromJson(v));
      });
    }
    return dataList;
  }

  List<EarningSummary> getPassbookDataList() {
    List<EarningSummary> dataList = [];
    if (response.containsKey('EarningSummary')) {
      response['EarningSummary'].forEach((v) {
        dataList.add(EarningSummary.fromJson(v));
      });
    }
    return dataList;
  }

  List<LoginInfo> getLoginInfo() {
    List<LoginInfo> dataList = [];
    if (response.containsKey('Login_Info')) {
      response['Login_Info'].forEach((v) {
        dataList.add(LoginInfo.fromJson(v));
      });
    }
    return dataList;
  }

  List<PoliticalGeoLevel> getPoliticalGeoLevel() {
    List<PoliticalGeoLevel> dataList = [];
    if (response.containsKey('PoliticalGeoLevel')) {
      response['PoliticalGeoLevel'].forEach((v) {
        dataList.add(PoliticalGeoLevel.fromJson(v));
      });
    }
    return dataList;
  }

  List<GeoData> getGeoDetail1() {
    List<GeoData> geoDetailsOneList = [];
    if (response.containsKey('PoliticalGeoDetails')) {
      response['PoliticalGeoDetails'].forEach((v) {
        geoDetailsOneList.add(GeoData.fromJson(v));
      });
    }
    return geoDetailsOneList;
  }

  List<GeoData> getGeoDetail2() {
    List<GeoData> geoDetailsTwoList = [];
    if (response.containsKey('PoliticalGeoDetails')) {
      response['PoliticalGeoDetails'].forEach((v) {
        geoDetailsTwoList.add(GeoData.fromJson(v));
      });
    }
    return geoDetailsTwoList;
  }

  List<GeoData> getGeoDetail3() {
    List<GeoData> geoDetailsThreeList = [];
    if (response.containsKey('PoliticalGeoDetails')) {
      response['PoliticalGeoDetails'].forEach((v) {
        geoDetailsThreeList.add(GeoData.fromJson(v));
      });
    }
    return geoDetailsThreeList;
  }

//  List<ProductInformationModel> getProductInfoDetail() {
//    List<ProductInformationModel> geoDetailsThreeList = List();
//    if (response.containsKey('ProductInformation')) {
//      response['ProductInformation'].forEach((v) {
//        geoDetailsThreeList.add(ProductInformationModel.fromJson(v));
//      });
//    }
//    return geoDetailsThreeList;
//  }

  List<NotificationModel> getNotificationCount() {
    List<NotificationModel> notificationList = [];
    if (response.containsKey("Notification")) {
      response["Notification"].forEach((v) {
        notificationList.add(NotificationModel.fromJson(v));
      });
    }
    return notificationList;
  }

  List<NotificationNewModel> getNotificationDetail() {
    List<NotificationNewModel> notificationList = [];
    if (response.containsKey("Notification")) {
      response["Notification"].forEach((v) {
        notificationList.add(NotificationNewModel.fromJson(v));
      });
    }
    return notificationList;
  }

  List<GRListModel> getGRList() {
    List<GRListModel> grListList = [];
    if (response.containsKey("GRList")) {
      response["GRList"].forEach((v) {
        grListList.add(GRListModel.fromJson(v));
      });
    }
    return grListList;
  }

  List<GRProductListModel> getGRProductList() {
    List<GRProductListModel> grListList = [];
    if (response.containsKey("GRProductList")) {
      response["GRProductList"].forEach((v) {
        grListList.add(GRProductListModel.fromJson(v));
      });
    }
    return grListList;
  }

  List<SubZoneModel> getZoneList() {
    List<SubZoneModel> grListList = [];
    if (response.containsKey("Zone")) {
      response["Zone"].forEach((v) {
        grListList.add(SubZoneModel.fromJson(v));
      });
    }
    return grListList;
  }

  List<SubZoneModel> getSubZoneList() {
    List<SubZoneModel> grListList = [];
    if (response.containsKey("SubZone")) {
      response["SubZone"].forEach((v) {
        grListList.add(SubZoneModel.fromJson(v));
      });
    }
    return grListList;
  }

  List<POScanningDetails> getPOScanningDetails() {
    List<POScanningDetails> grListList = [];
    if (response.containsKey("POScanningDetails")) {
      response["POScanningDetails"].forEach((v) {
        grListList.add(POScanningDetails.fromJson(v));
      });
    }
    return grListList;
  }

  List<ScanningSummaryModel> getScanningSummary() {
    List<ScanningSummaryModel> grListList = [];
    if (response.containsKey("ScanningSummary")) {
      response["ScanningSummary"].forEach((v) {
        grListList.add(ScanningSummaryModel.fromJson(v));
      });
    }
    return grListList;
  }

  List<ScanningSummaryModel> getScanning() {
    List<ScanningSummaryModel> grListList = [];
    if (response.containsKey("Scanning")) {
      response["Scanning"].forEach((v) {
        grListList.add(ScanningSummaryModel.fromJson(v));
      });
    }
    return grListList;
  }

  List<PGIListModel> getPGIList() {
    List<PGIListModel> grListList = [];
    if (response.containsKey("DispatchList")) {
      response["DispatchList"].forEach((v) {
        grListList.add(PGIListModel.fromJson(v));
      });
    }
    return grListList;
  }

  int? getGRCount() {
    //List<PGIListModel> grListList = List();
    int? GRCount = 0;
    try {
      if (response.containsKey("GRCNT")) {
        response["GRCNT"].forEach((v) {
          GRCount = v['intGRCNT'];
        });
      }
    } catch (e) {
      print(e.toString());
    }
    return GRCount;
  }
}

class UploadFileResponseModel {
  bool? status;
  String? message;
  String? dateFolder;
  int? syncLogId;

  UploadFileResponseModel(
      {this.status, this.message, this.dateFolder, this.syncLogId});

  UploadFileResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    dateFolder = json['date_folder'];
    syncLogId = json['sync_log_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['date_folder'] = this.dateFolder;
    data['sync_log_id'] = this.syncLogId;
    return data;
  }
}

class DownloadFileResponseModel {
  bool? status;
  String? message;
  String? filename;
  String? downloadUrl;

  DownloadFileResponseModel(
      {this.status, this.message, this.filename, this.downloadUrl});

  DownloadFileResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    filename = json['filename'];
    downloadUrl = json['download_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['filename'] = this.filename;
    data['download_url'] = this.downloadUrl;
    return data;
  }
}

class OfferPointResponseModel {
  bool? status;
  String? message;
  String? points;

  OfferPointResponseModel({this.status, this.message, this.points});

  OfferPointResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['points'] = this.points;
    return data;
  }
}
