class NotificationResponseModel {
  bool? status;
  String? message;
  var notification_data;

  factory NotificationResponseModel.fromJsonStatus(Map<String, dynamic> json) {
    return NotificationResponseModel(
      status: json['status'],
      message: json['message'],
      notification_data: json['notification_data'],
    );
  }

  NotificationResponseModel(
      {this.status, this.message, this.notification_data});

  List<NotificationData> getNotificationDataList() {
    List<NotificationData> dataList = [];
    if (notification_data != null) {
      notification_data.forEach((v) {
        dataList.add(NotificationData.fromJson(v));
      });
    }
    return dataList;
  }
}

class NotificationData {
  String? notificationId;
  String? subject;
  String? brief;
  String? customerType;
  String? ntfType;
  String? ntfTitle;
  String? notificationDate;
  String? display_name;
  String? user_code;
  String? BoxRejected;
  String? BoxPending;
  String? BoxAccepted;
  String? Boxes;
  String? product_sku_name;
  String? received_date;
  String? return_date;
  String? TotalBox;
  String? return_request_date;

  NotificationData(
      {this.notificationId,
      this.subject,
      this.brief,
      this.customerType,
      this.ntfType,
      this.ntfTitle,
      this.notificationDate,
      this.display_name,
      this.user_code,
      this.BoxRejected,
      this.BoxPending,
      this.BoxAccepted,
      this.Boxes,
      this.product_sku_name,
      this.received_date,
      this.return_date,
      this.TotalBox,
      this.return_request_date});

  NotificationData.fromJson(Map<String, dynamic> json) {
    notificationId = json['notification_id'];
    subject = json['subject'];
    brief = json['brief'];
    customerType = json['customer_type'];
    ntfType = json['ntf_type'];
    ntfTitle = json['ntf_title'];
    notificationDate = json['notification_date'];
    display_name = json.containsKey('display_name') ? json['display_name'] : '';
    user_code = json.containsKey('user_code') ? json['user_code'] : '';
    BoxRejected = json.containsKey('BoxRejected') ? json['BoxRejected'] : '';
    BoxPending = json.containsKey('BoxPending') ? json['BoxPending'] : '';
    BoxAccepted = json.containsKey('BoxAccepted') ? json['BoxAccepted'] : '';
    Boxes = json.containsKey('Boxes') ? json['Boxes'] : '';
    product_sku_name =
        json.containsKey('product_sku_name') ? json['product_sku_name'] : '';
    received_date =
        json.containsKey('received_date') ? json['received_date'] : '';
    return_date = json.containsKey('return_date') ? json['return_date'] : '';
    TotalBox = json.containsKey('TotalBox') ? json['TotalBox'] : '';
    return_request_date = json.containsKey('return_request_date')
        ? json['return_request_date']
        : '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_id'] = this.notificationId;
    data['subject'] = this.subject;
    data['brief'] = this.brief;
    data['customer_type'] = this.customerType;
    data['ntf_type'] = this.ntfType;
    data['ntf_title'] = this.ntfTitle;
    data['notification_date'] = this.notificationDate;
    data['display_name'] != null ? this.display_name : '';
    data['user_code'] != null ? this.user_code : '';
    data['BoxRejected'] != null ? this.BoxRejected : '';
    data['BoxPending'] != null ? this.BoxPending : '';
    data['BoxAccepted'] != null ? this.BoxAccepted : '';
    data['Boxes'] != null ? this.Boxes : '';
    data['product_sku_name'] != null ? this.product_sku_name : '';
    data['received_date'] != null ? this.received_date : '';
    data['return_date'] != null ? this.return_date : '';
    data['TotalBox'] != null ? this.TotalBox : '';
    data['return_request_date'] != null ? this.return_request_date : '';
    return data;
  }
}
