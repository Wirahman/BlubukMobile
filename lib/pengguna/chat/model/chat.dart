class VariabelSemuaChat {
  String userIDTeman;
  String emailTeman;
  String namaTeman;
  String fotoProfilTeman;
  String idChat;
  String idBalasChat;
  String pesan;
  String waktu;
  String fotoChat;
  String jumlahFotoChat;

  VariabelSemuaChat(
      {
        this.userIDTeman,
        this.emailTeman,
        this.namaTeman,
        this.fotoProfilTeman,
        this.idChat,
        this.idBalasChat,
        this.pesan,
        this.waktu,
        this.fotoChat,
        this.jumlahFotoChat
      });

  factory VariabelSemuaChat.fromJson(Map<String, dynamic> json) {
    return new VariabelSemuaChat(
        userIDTeman: json['userIDTeman'] as String,
        emailTeman: json['emailTeman'] as String,
        namaTeman: json['namaTeman'] as String,
        fotoProfilTeman: json['fotoProfilTeman'] as String,
        idChat: json['idChat'] as String,
        idBalasChat: json['idBalasChat'] as String,
        pesan: json['pesan'] as String,
        waktu: json['waktu'] as String,
        fotoChat: json['fotoChat'] as String,
        jumlahFotoChat: json['jumlahFotoChat'] as String
    );
  }

}

