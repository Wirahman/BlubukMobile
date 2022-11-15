class VariabelFotoKomentarForum {
  String idForum;
  String idKomentarForum;
  String namaFile;

  VariabelFotoKomentarForum(
      {
        this.idForum,
        this.idKomentarForum,
        this.namaFile,
      }
      );

  factory VariabelFotoKomentarForum.fromJson(Map<String, dynamic> json) {
    return new VariabelFotoKomentarForum(
      idForum: json['idForum'] as String,
      idKomentarForum: json['idKomentarForum'] as String,
      namaFile: json['namaFile'] as String,
    );
  }

}