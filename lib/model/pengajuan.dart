class Pengajuan {
  String? kode_pengajuan;
  String? tanggal;
  String? npm_peminjam;
  String? nama_peminjam;
  String? prodi;
  String? no_handphone;

  Pengajuan({
    this.kode_pengajuan,
    this.tanggal,
    this.npm_peminjam,
    this.nama_peminjam,
    this.prodi,
    this.no_handphone,
  });

  factory Pengajuan.fromJson(Map<String, dynamic> json) => Pengajuan(
        kode_pengajuan: json['kode_pengajuan'],
        tanggal: json['tanggal'],
        npm_peminjam: json['npm_peminjam'],
        nama_peminjam: json['nama_peminjam'],
        prodi: json['prodi'],
        no_handphone: json['no_handphone'],
      );

  Map<String, dynamic> toJson() => {
        'kode_pengajuan': this.kode_pengajuan,
        'tanggal': this.tanggal,
        'npm_peminjam': this.npm_peminjam,
        'nama_peminjam': this.nama_peminjam,
        'prodi': this.prodi,
        'no_handphone': this.no_handphone,
      };
}
