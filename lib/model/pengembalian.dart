class Pengembalian {
  String? kode_pengembalian;
  String? kode_pengajuan;
  String? tanggal_kembali;

  Pengembalian({
    this.kode_pengembalian,
    this.kode_pengajuan,
    this.tanggal_kembali,
  });

  factory Pengembalian.fromJson(Map<String, dynamic> json) => Pengembalian(
        kode_pengembalian: json['kode_pengembalian'],
        kode_pengajuan: json['kode_pengajuan'],
        tanggal_kembali: json['tanggal_kembali'],
      );

  Map<String, dynamic> toJson() => {
        'kode_pengembalian': this.kode_pengembalian,
        'kode_pengajuan': this.kode_pengajuan,
        'tanggal_kembali': this.tanggal_kembali,
      };
}
