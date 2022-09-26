class ResBanner {
  int? bannerId;
  String? namaFile;

  ResBanner({this.bannerId, this.namaFile});

  ResBanner.fromJson(Map<String, dynamic> json) {
    bannerId = json['banner_id'];
    namaFile = json['nama_file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['banner_id'] = bannerId;
    data['nama_file'] = namaFile;
    return data;
  }
}
