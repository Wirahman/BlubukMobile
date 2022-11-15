class VariabelStatus {
  String idStatus;
  String userID;
  String fotoProfil;
  String email;
  String name;
  String isi;
  String waktu;
  String foto;
  String suka;
  String benci;
  String fotoStatus;
  String jumlahFotoStatus;

  VariabelStatus(
    {
      this.idStatus,
      this.userID,
      this.fotoProfil,
      this.email,
      this.name,
      this.isi,
      this.waktu,
      this.foto,
      this.suka,
      this.benci,
      this.fotoStatus,
      this.jumlahFotoStatus
    }
  );
  
  factory VariabelStatus.fromJson(Map<String, dynamic> json) {
    return new VariabelStatus(
        idStatus: json['idStatus'] as String,
        userID: json['userID'] as String,
        fotoProfil: json['fotoProfil'] as String,
        email: json['email'] as String,
        name: json['name'] as String,
        isi: json['isi'] as String,
        waktu: json['waktu'] as String,
        foto: json['foto'] as String,
        suka: json['suka'] as String,
        benci: json['benci'] as String,
        fotoStatus: json['fotoStatus'] as String,
        jumlahFotoStatus: json['jumlahFotoStatus'] as String
      );
  }

}