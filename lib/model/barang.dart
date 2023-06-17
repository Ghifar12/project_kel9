class Barang {
  String? kode_barang;
  String? nama_barang;
  String? jumlah;

  Barang({
    this.kode_barang,
    this.nama_barang,
    this.jumlah,
  });

  factory Barang.fromJson(Map<String, dynamic> json) => Barang(
        kode_barang: json['kode_barang'],
        nama_barang: json['nama_barang'],
        jumlah: json['jumlah'],
      );

  Map<String, dynamic> toJson() => {
        'kode_barang': this.kode_barang,
        'nama_barang': this.nama_barang,
        'jumlah': this.jumlah,
      };
}
