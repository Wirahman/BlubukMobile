class VariabelBalasChat {
  String userID;
  String nama;
  String fotoProfil;
  String idChat;
  String idBalasChat;
  String pesan;
  String waktu;
  String fotoBalasChat;
  String jumlahFotoBalasChat;

  VariabelBalasChat({
    this.userID,
    this.nama,
    this.fotoProfil,
    this.idChat,
    this.idBalasChat,
    this.pesan,
    this.waktu,
    this.fotoBalasChat,
    this.jumlahFotoBalasChat,
  });

  factory VariabelBalasChat.fromJson(Map<String, dynamic> json) {
    return new VariabelBalasChat(
      userID: json['userID'] as String,
      nama: json['nama'] as String,
      fotoProfil: json['fotoProfil'] as String,
      idChat: json['idChat'] as String,
      idBalasChat: json['idBalasChat'] as String,
      pesan: json['pesan'] as String,
      waktu: json['waktu'] as String,
      fotoBalasChat: json['fotoBalasChat'] as String,
      jumlahFotoBalasChat: json['jumlahFotoBalasChat'] as String,
    );
  }
}


