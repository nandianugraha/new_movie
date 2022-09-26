import 'dart:convert';

class ReqRegisterModel {
  String? name;
  String? telp;
  String? password;
  String? confPassword;
  String? alamat;
  String? kapal1;
  String? kapal2;
  String? kapal3;

  ReqRegisterModel(
      {this.name,
      this.telp,
      this.password,
      this.confPassword,
      this.alamat,
      this.kapal1,
      this.kapal2,
      this.kapal3});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama_lengkap'] = name ?? '';
    data['no_hp'] = telp ?? '';
    data['user_pass'] = password ?? '';
    data['user_pass_konfirmasi'] = confPassword ?? '';
    data['alamat'] = alamat ?? '';
    data['kapal_1'] = kapal1 ?? '';
    data['kapal_2'] = kapal2 ?? '';
    data['kapal_3'] = kapal3 ?? '';
    return data;
  }
}
