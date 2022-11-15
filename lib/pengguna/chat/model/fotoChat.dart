class VariabelFotoChat {
  String idChat;
  String idBalasChat;
  String namaFile;

  VariabelFotoChat(
      {
        this.idChat,
        this.idBalasChat,
        this.namaFile,
      }
    );

  factory VariabelFotoChat.fromJson(Map<String, dynamic> json) {
    return new VariabelFotoChat(
        idChat: json['idChat'] as String,
        idBalasChat: json['idBalasChat'] as String,
        namaFile: json['namaFile'] as String,
    );
  }

}