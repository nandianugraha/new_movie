class ResKapal {
  String? kapalId;
  String? noRegis;
  int? userId;
  String? namaKapal;
  String? digunakanSt;
  String? langitude;
  String? latitude;
  String? sosSt;

  ResKapal(
      {this.kapalId,
      this.noRegis,
      this.userId,
      this.namaKapal,
      this.digunakanSt,
      this.langitude,
      this.latitude,
      this.sosSt});

  ResKapal.fromJson(Map<String, dynamic> json) {
    kapalId = '${json['kapal_id']}';
    noRegis = '${json['no_regis']}';
    userId = json['user_id'];
    namaKapal = json['nama_kapal'];
    digunakanSt = json['digunakan_st'];
    langitude = json['langitude'];
    latitude = json['latitude'];
    sosSt = json['sos_st'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kapal_id'] = kapalId;
    data['no_regis'] = noRegis;
    data['user_id'] = userId;
    data['nama_kapal'] = namaKapal;
    data['digunakan_st'] = digunakanSt;
    data['langitude'] = langitude;
    data['latitude'] = latitude;
    data['sos_st'] = sosSt;
    return data;
  }
}
