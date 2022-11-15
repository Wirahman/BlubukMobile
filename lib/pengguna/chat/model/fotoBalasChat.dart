class VariabelFotoBalasChat {
  String idChat;
  String idBalasChat;
  String namaFile;

  VariabelFotoBalasChat(
      {
        this.idChat,
        this.idBalasChat,
        this.namaFile,
      }
      );

  factory VariabelFotoBalasChat.fromJson(Map<String, dynamic> json) {
    return new VariabelFotoBalasChat(
      idChat: json['idChat'] as String,
      idBalasChat: json['idBalasChat'] as String,
      namaFile: json['namaFile'] as String,
    );
  }

}