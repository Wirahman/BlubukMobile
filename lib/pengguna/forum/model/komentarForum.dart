class VariabelKomentarForum {
  String idKomentarForum;
  String userIDPembuatForum;
  String userIDPemberiKomentar;
  String isiKomentarForum;
  String namaPemberiKomentar;
  String fotoProfilPemberiKomentar;
  String fotoKomentarForum;
  String waktu;
  String userIDSuka;
  String statusSuka;
  String userIDBenci;
  String statusBenci;

  VariabelKomentarForum({
    this.idKomentarForum,
    this.userIDPembuatForum,
    this.userIDPemberiKomentar,
    this.isiKomentarForum,
    this.namaPemberiKomentar,
    this.fotoProfilPemberiKomentar,
    this.fotoKomentarForum,
    this.waktu,
    this.userIDSuka,
    this.statusSuka,
    this.userIDBenci,
    this.statusBenci
  });

  factory VariabelKomentarForum.fromJson(Map<String, dynamic> json) {
    return new VariabelKomentarForum(
      idKomentarForum: json['idKomentarForum'] as String,
      userIDPembuatForum: json['userIDPembuatForum'] as String,
      userIDPemberiKomentar: json['userIDPemberiKomentar'] as String,
      isiKomentarForum: json['isiKomentarForum'] as String,
      namaPemberiKomentar: json['namaPemberiKomentar'] as String,
      fotoProfilPemberiKomentar: json['fotoProfilPemberiKomentar'] as String,
      fotoKomentarForum: json['fotoKomentarForum'] as String,
      waktu: json['waktu'] as String,
      userIDSuka: json['userIDSuka'] as String,
      statusSuka: json['statusSuka'] as String,
      userIDBenci: json['userIDBenci'] as String,
      statusBenci: json['statusBenci'] as String
    );
  }
}


