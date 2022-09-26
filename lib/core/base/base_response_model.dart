class BaseResponseModel {
  int? statusCode;
  bool? notifSt;
  String? notifMsg;
  String? data;

  BaseResponseModel({this.statusCode, this.notifSt, this.notifMsg, this.data});

  BaseResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    notifSt = json['notif_st'];
    notifMsg = json['notif_msg'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['notif_st'] = notifSt;
    data['notif_msg'] = notifMsg;
    data['data'] = data;
    return data;
  }
}
