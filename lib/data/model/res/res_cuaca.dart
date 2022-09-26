class ResCuaca {
  String? code;
  String? name;
  String? issued;
  List<dynamic>? data;

  ResCuaca({this.code, this.name, this.issued, this.data});

  factory ResCuaca.fromJson(Map<String, dynamic> json) {
    return ResCuaca(
        code: json['code'],
        name: json['name'],
        issued: json['issued'],
        data: json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    data['issued'] = issued;
    data['data'] = this.data?.map((v) => v.toJson()).toList();
    return data;
  }
}

class Data {
  String? validFrom;
  String? validTo;
  String? timeDesc;
  String? weather;
  String? weatherDesc;
  String? warningDesc;
  String? stationRemark;
  String? waveCat;
  String? waveDesc;
  String? windFrom;
  String? windTo;
  int? windSpeedMin;
  int? windSpeedMax;

  Data(
      {this.validFrom,
      this.validTo,
      this.timeDesc,
      this.weather,
      this.weatherDesc,
      this.warningDesc,
      this.stationRemark,
      this.waveCat,
      this.waveDesc,
      this.windFrom,
      this.windTo,
      this.windSpeedMin,
      this.windSpeedMax});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      validFrom: json['valid_from'] ?? "",
      validTo: json['valid_to'] ?? "",
      timeDesc: json['time_desc'] ?? "",
      weather: json['weather'] ?? "",
      weatherDesc: json['weather_desc'] ?? "",
      warningDesc: json['warning_desc'] ?? "",
      stationRemark: json['station_remark'] ?? "",
      waveCat: json['wave_cat'] ?? "",
      waveDesc: json['wave_desc'] ?? "",
      windFrom: json['wind_from'] ?? "",
      windTo: json['wind_to'] ?? "",
      windSpeedMin: json['wind_speed_min'] ?? "",
      windSpeedMax: json['wind_speed_max'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['valid_from'] = validFrom;
    data['valid_to'] = validTo;
    data['time_desc'] = timeDesc;
    data['weather'] = weather;
    data['weather_desc'] = weatherDesc;
    data['warning_desc'] = warningDesc;
    data['station_remark'] = stationRemark;
    data['wave_cat'] = waveCat;
    data['wave_desc'] = waveDesc;
    data['wind_from'] = windFrom;
    data['wind_to'] = windTo;
    data['wind_speed_min'] = windSpeedMin;
    data['wind_speed_max'] = windSpeedMax;
    return data;
  }
}
