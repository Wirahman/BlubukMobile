class VariabelKomentarStatus {
  String userID;
  String idStatus;
  String idKomentarStatus;
  String fotoProfil;
  String email;
  String name;
  String isi;
  String waktu;
  String foto;
  String userIDSuka;
  String statusSuka;
  String userIDBenci;
  String statusBenci;
  String fotoKomentarStatus;
  String jumlahFotoKomentarStatus;

  VariabelKomentarStatus(
    {
      this.userID,
      this.idStatus,
      this.idKomentarStatus,
      this.fotoProfil,
      this.email,
      this.name,
      this.isi,
      this.waktu,
      this.foto,
      this.userIDSuka,
      this.statusSuka,
      this.userIDBenci,
      this.statusBenci,
      this.fotoKomentarStatus,
      this.jumlahFotoKomentarStatus
    }
 );

  factory VariabelKomentarStatus.fromJson(Map<String, dynamic> json) {
    // print("Ini json");
    // print(json);

    return new VariabelKomentarStatus(
        userID: json['userID'] as String,
        idStatus: json['idStatus'] as String,
        idKomentarStatus: json['idKomentarStatus'] as String,
        fotoProfil: json['fotoProfil'] as String,
        email: json['email'] as String,
        name: json['name'] as String,
        isi: json['isi'] as String,
        waktu: json['waktu'] as String,
        foto: json['foto'] as String,
        userIDSuka: json['userIDSuka'] as String,
        statusSuka: json['statusSuka'] as String,
        userIDBenci: json['userIDBenci'] as String,
        statusBenci: json['statusBenci'] as String,
        fotoKomentarStatus: json['fotoKomentarStatus'] as String,
        jumlahFotoKomentarStatus: json['jumlahFotoKomentarStatus'] as String
    );
  }

}