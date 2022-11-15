class VariabelFotoForum {
  String idForum;
  String namaFile;

  VariabelFotoForum(
      {
        this.idForum,
        this.namaFile,
      }
      );

  factory VariabelFotoForum.fromJson(Map<String, dynamic> json) {
    return new VariabelFotoForum(
      idForum: json['idForum'] as String,
      namaFile: json['namaFile'] as String,
    );
  }

}