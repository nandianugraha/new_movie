class ResInfo {
  int? informasiId;
  int? kategoriId;
  String? informasiJudul;
  String? informasiCatatan;
  String? namaFile;
  String? informasiSt;
  String? kategoriNama;

  ResInfo(
      {this.informasiId,
      this.kategoriId,
      this.informasiJudul,
      this.informasiCatatan,
      this.namaFile,
      this.informasiSt,
      this.kategoriNama});

  ResInfo.fromJson(Map<String, dynamic> json) {
    informasiId = json['informasi_id'];
    kategoriId = json['kategori_id'];
    informasiJudul = json['informasi_judul'];
    informasiCatatan = json['informasi_catatan'];
    namaFile = json['nama_file'];
    informasiSt = json['informasi_st'];
    kategoriNama = json['kategori_nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['informasi_id'] = informasiId;
    data['kategori_id'] = kategoriId;
    data['informasi_judul'] = informasiJudul;
    data['informasi_catatan'] = informasiCatatan;
    data['nama_file'] = namaFile;
    data['informasi_st'] = informasiSt;
    data['kategori_nama'] = kategoriNama;
    return data;
  }
}