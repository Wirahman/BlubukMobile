class VariabelStatus {
  String userID;
  String fotoProfil;
  String email;
  String name;
  String isi;
  String waktu;
  String foto;

  VariabelStatus(
    {
      this.userID,
      this.fotoProfil,
      this.email,
      this.name,
      this.isi,
      this.waktu,
      this.foto
    }
  );
  
  factory VariabelStatus.fromJson(Map<String, dynamic> json) {
    // print("Ini json");
    // print(json);

    return new VariabelStatus(
        userID: json['userID'] as String,
        fotoProfil: json['fotoProfil'] as String,
        email: json['email'] as String,
        name: json['name'] as String,
        isi: json['isi'] as String,
        waktu: json['waktu'] as String,
        foto: json['foto'] as String
      );
  }

}