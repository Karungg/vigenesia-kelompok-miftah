class MotivasiModel {
  final String? id;
  final String? idUser;
  final String? isiMotivasi;
  final String? idKategori;
  final String? tanggalInput;
  final String? tanggalUpdate;
  final String? nama;

  MotivasiModel({
    this.id,
    this.idUser,
    this.isiMotivasi,
    this.idKategori,
    this.tanggalInput,
    this.tanggalUpdate,
    this.nama
  });

  factory MotivasiModel.fromJson(Map<String, dynamic> json) {
    return MotivasiModel(
      id: json['id'].toString(),
      idUser: json['id_user'].toString(),
      isiMotivasi: json['isi_motivasi'].toString(),
      idKategori: json['id_kategori'].toString(),
      tanggalInput: json['tanggal_input'].toString(),
      tanggalUpdate: json['tanggal_update'].toString(),
      nama: json['nama'].toString()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_user': idUser,
      'isi_motivasi': isiMotivasi,
      'id_kategori': idKategori,
      'tanggal_input': tanggalInput,
      'tanggal_update': tanggalUpdate,
      'nama' : nama
    };
  }
}
