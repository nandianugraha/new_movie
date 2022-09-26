class ResCategory {
  int? kategoriId;
  String? kategoriNama;
  String? kategoriDesc;
  String? aktifSt;

  ResCategory(
      {this.kategoriId, this.kategoriNama, this.kategoriDesc, this.aktifSt});

  ResCategory.fromJson(Map<String, dynamic> json) {
    kategoriId = json['kategori_id'];
    kategoriNama = json['kategori_nama'];
    kategoriDesc = json['kategori_desc'];
    aktifSt = json['aktif_st'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kategori_id'] = kategoriId;
    data['kategori_nama'] = kategoriNama;
    data['kategori_desc'] = kategoriDesc;
    data['aktif_st'] = aktifSt;
    return data;
  }
}
